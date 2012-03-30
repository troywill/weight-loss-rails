class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true

  scope :by_user, lambda { |user_id| where('user_id = ?', user_id) }

  def self.time_initial( user_id )
    return Reading.order('reading_time ASC').where(:user_id => user_id).first.reading_time
  end

 def self.weight_initial( user_id )
    return Reading.order('reading_time ASC').where(:user_id => user_id).first.weight
  end

  def self.weight_at_time(user_id, time)
    time_initial = Reading.time_initial(user_id)
    weight_initial = Reading.weight_initial(user_id)
    if ( time < time_initial )
      return weight_initial
    end
    max_gain_rate = User.filter_rate_gain(user_id)
    max_loss_rate = User.filter_rate_loss(user_id)
    readings = Reading.get_readings_after( user_id, time_initial, time )
    for reading in readings
      w = apply_filter(max_gain_rate, max_loss_rate, time_initial, weight_initial, reading.reading_time, reading.weight)
      time_initial = reading.reading_time
      weight_initial = w
    end
    next_reading = Reading.get_next_reading_after(user_id, time)
    if next_reading
      weight = interpolate( max_gain_rate, max_loss_rate, time_initial, weight_initial, next_reading.reading_time, next_reading.weight, time )
    else
      weight = apply_filter(max_gain_rate, max_loss_rate, time_initial, weight_initial, time, reading.weight)
    end
    #    return number_with_precision(weight, :precision => 5 )                                                                   return weight
  end

    def self.get_readings_after( user_id, start_time, end_time )
    return Reading.order('reading_time ASC').where(:user_id => user_id).where('reading_time >= ? AND reading_time <= ?', start_time, end_time)
  end                                                                                                                         
  def self.get_next_reading_after( user_id, time )
    return Reading.order('reading_time ASC').where(:user_id => user_id).where('reading_time > ?', time).first
  end

  def self.apply_filter( max_gain_rate, max_loss_rate, initial_time, initial_weight, time, weight )
    if ( weight == initial_time )
      return weight
    else
      delta_time = ( time - initial_time ).to_i
      cals_day_pounds_second = 1.0 / 86400.0 / 3500.0
      max_allowable_weight = initial_weight + ( max_gain_rate * cals_day_pounds_second * delta_time )
      min_allowable_weight = initial_weight - ( max_loss_rate * cals_day_pounds_second * delta_time )
      if ( weight > max_allowable_weight )
        return max_allowable_weight
      end
      if ( weight < min_allowable_weight )
        return min_allowable_weight
      end
    end
    return  weight
  end

  def self.interpolate( max_gain_rate, max_loss_rate, last_time, last_weight, next_time, next_weight, time )
    filtered_next_weight = apply_filter(max_gain_rate, max_loss_rate, last_time, last_weight, next_time, next_weight )
    delta_time = next_time - last_time
    delta_weight = ( filtered_next_weight - last_weight )
    percent = ( time - last_time ) / delta_time.to_f
    interpolated_weight = last_weight + percent * delta_weight
  end

  def self.get_last_reading( user_id )
    return Reading.order('reading_time ASC').where(:user_id => user_id).last
  end

  def self.get_goal_difference
    return 1
  end

end
