class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :phone, :presence => true
  validates :height, :presence => true, :numericality => true
  validates :sex, :presence => true
  validates :goal_start_weight, :presence => true, :numericality => true
  validates :goal_start_time, :presence => true, :numericality => true
  validates :goal_loss_rate, :presence => true, :numericality => true
  validates :filter_rate_gain, :presence => true, :numericality => true
  validates :filter_rate_loss, :presence => true, :numericality => true
  validates :shared_doc, :presence => true

  def self.authenticate(email)
    user = self.find_by_email(email)
    if user
      if user.email != email
        user = nil
      end
    end
    user
  end

  def self.goal_now(user_id)
    u = User.find(user_id)
    elapsed_time = Time.now - u.goal_start_time
    lbs_per_second = ( u.goal_loss_rate / 86400.0 / 3500.0 )
    return ( u.goal_start_weight - lbs_per_second * elapsed_time )
  end
  
  def self.filter_rate_gain(user_id)
    return User.where(:id => user_id).first.filter_rate_gain
  end
  
  def self.filter_rate_loss(user_id)
    return User.where(:id => user_id).first.filter_rate_loss
  end
  
  def self.goal_loss_rate(user_id)
    cals_per_day = User.where(:id => user_id).first.goal_loss_rate
    lbs_per_second = cals_per_day / 3500.0 / 86400.0
    return  lbs_per_second
  end

  def self.get_readings_after( user_id, start_time, end_time )
    return Reading.order('reading_time ASC').where(:user_id => user_id).where('reading_time >= ? AND reading_time <= ?', start_time, end_time)
  end                                                                                                                         
  def self.get_next_reading_after( user_id, time )
    return Reading.order('reading_time ASC').where(:user_id => user_id).where('reading_time > ?', time).first
  end
end

