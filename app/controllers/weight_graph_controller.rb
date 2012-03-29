class WeightGraphController < ApplicationController
  def week
  end

  def month
    g = Gruff::Line.new
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
      weight_array.push(weight)
    end

    g.data "28 days", weight_array
    send_data(g.to_blob, :type => 'image/png', :filename => "28days.png")
    
  end

  def year
  end
end
