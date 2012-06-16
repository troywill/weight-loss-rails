class WeightGraphController < ApplicationController
  def week
  end

  def month
    g = Gruff::Line.new
    # Next line is transient bug fix (TDW)
    g.marker_count = 4 #explicitly assign value to @marker_count
    weight = 0
    time_at_point_in_past = 0
    user_id = session[:user_id]
    time_first_reading = Reading.time_initial(user_id)
    weight_first_reading = Reading.weight_initial(user_id).to_f
    # Get weight values for last 28 days
    weight_array = Array.new
    number_of_periods = 28
    (0..number_of_periods).each do |period_num|
      time_at_point_in_past = Time.now-(number_of_periods-period_num).day

      if ( time_at_point_in_past < time_first_reading )
        weight = weight_first_reading
      else
        weight = Reading.weight_at_time(user_id, time_at_point_in_past)
      end
      logger.debug "DEBUG: #{weight}"
      weight_array.push(weight)
    end

#    n = number_with_precision(weight)
    g.data "#{weight}", weight_array
    send_data(g.to_blob, :type => 'image/png')
    logger.flush
  end

  def year
    logger.debug "TDW year"
    g = Gruff::Line.new
    # Next line is transient bug fix ( TDW )
    g.marker_count = 4 #explicitly assign value to @marker_count
    weight = 0
    time_at_point_in_past = 0
    user_id = session[:user_id]
    time_first_reading = Reading.time_initial(user_id)
    weight_first_reading = Reading.weight_initial(user_id).to_f
    # Get weight values for last 12 months
    weight_array = Array.new
    number_of_periods = 12
    (0..number_of_periods).each do |period_num|
      time_at_point_in_past = Time.now-(number_of_periods-period_num).month

      if ( time_at_point_in_past < time_first_reading )
        weight = weight_first_reading
      else
        weight = Reading.weight_at_time(user_id, time_at_point_in_past)
      end
      weight_array.push(weight)
    end

    g.data "Last 12 months", weight_array
    send_data(g.to_blob, :type => 'image/png')
  end
end


























  # def month
  #   logger.debug "TDW month"

  #   g = Gruff::Line.new
  #   weight = 0
  #   time_at_point_in_past = 0
  #   user_id = session[:user_id]
  #   time_first_reading = Reading.time_initial(user_id)
  #   weight_first_reading = Reading.weight_initial(user_id).to_f
  #   # Get weight values for last 28 days
  #   weight_array = Array.new
  #   number_of_periods = 28
  #   (0..number_of_periods).each do |period_num|
  #     time_at_point_in_past = Time.now-(number_of_periods-period_num).day

  #     if ( time_at_point_in_past < time_first_reading )
  #       weight = weight_first_reading
  #     else
  #       weight = Reading.weight_at_time(user_id, time_at_point_in_past)
  #     end
  #     weight_array.push(weight)
  #   end

  #   g.data "#{weight_array[0]}", weight_array
  #   send_data(g.to_blob, :type => 'image/png', :filename => "28days.png")
    
  # end
