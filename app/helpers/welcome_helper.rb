module WelcomeHelper
  def readings
    readings_table = "<table style='border-collapse: collapse'>\n<tr><caption>Weekly Scale Readings</caption>\n<thead>\n<tr><th>Weight</th><th>Date</th><th>Unix time</th></tr></thead><tbody>\n"
    for reading in @readings
      weight = "#{number_with_precision(reading.weight, :precision => 2 )}"
      time = reading.reading_time.to_formatted_s(:short)         # => "04 Dec 00:00"
      time = reading.reading_time.strftime("%e-%a %l:%M %p")
      time = reading.reading_time.strftime("%a %b %e")
      unix_time = reading.reading_time.to_i
      next unless reading.reading_time.strftime("%a") == Time.now.strftime("%a")
      table_row = ''
      if reading.reading_time.strftime("%a") == Time.now.strftime("%a")
       table_row = "<tr class='monday'>"
      else
       table_row = "<tr>"
      end
      string = "#{table_row}<td>#{weight}</td><td class='td_time'>#{time}</td><td>#{unix_time}</td></tr>"
      string = string + "\n"
      readings_table = readings_table + string
    end
    readings_table = readings_table + "</tbody>\n</table>\n"
    return readings_table.html_safe
  end

  def statistics_table
        readings_table = "<table style='border-collapse: collapse'>\n<tr><caption>Your Statistics</caption>\n<thead>\n<tr><th>Period</th><th>Lbs</th><th>Cals/day</th><th>lbs/wk</th><th>lbs/yr</th></tr></thead><tbody>\n"

    start_time = Setting.get_start_time(session[:user_id])
    start_time_string = time_ago_in_words( start_time )
    time_now = Time.now
    sixteen_weeks = time_now - 112.days
    eight_weeks = time_now - 56.days
    four_weeks = time_now - 28.days
    three_weeks = time_now - 21.days
    two_weeks = time_now - 14.days
    one_week = time_now - 7.days
    half_week = time_now - 3.5.days
    quarter_week = time_now - 1.75.days

    s = Statistics.new(session[:user_id])
    weight_now = s.weight_as_function_of_time(Time.now)

    times = [
             { :start_time => start_time, :description => start_time_string },
             { :start_time => sixteen_weeks, :description => '16 weeks' },
             { :start_time => eight_weeks, :description => '8 weeks' },
             { :start_time => four_weeks, :description => '4 weeks' },
             { :start_time => two_weeks, :description  => '2 weeks' },
             { :start_time => one_week, :description   => '1 week' },
             { :start_time => half_week, :description  => '3.5 days' }
            ]

    times.each do |t|
      next if t[:start_time] < start_time
      weight_at_start = s.weight_as_function_of_time(t[:start_time])

      weight_lost = weight_at_start - weight_now 
      weight_lost_string = number_with_precision(weight_lost, :precision => 2 )
      cals_per_day = (weight_lost / ( time_now - t[:start_time] ) * 86400 * 3500).round
      lbs_per_week = (weight_lost / ( time_now - t[:start_time] ) * 86400 * 7)
      lbs_per_week_string = number_with_precision(lbs_per_week, :precision => 1 )
      lbs_per_year = lbs_per_week * 52
      lbs_per_year_string = number_with_precision(lbs_per_year, :precision => 1 )
      lbs_per_year_string = lbs_per_year.round
      
      
      readings_table += "<tr style='text-align:right'><td>#{t[:description]}</td><td style='text-align:right'>#{weight_lost_string}</td><td>#{cals_per_day}</td><td>#{lbs_per_week_string}</td><td>#{lbs_per_year_string}</td></tr>"
    end
    readings_table = readings_table + "</tbody>\n</table>\n"
    return readings_table.html_safe
  end
  
end
