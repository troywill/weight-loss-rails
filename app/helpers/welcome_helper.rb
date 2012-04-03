module WelcomeHelper
  def loss_hours_ago_as_string(hours,hours_as_words)
    past_weight = Reading.weight_at_time(session[:user_id],Time.now-(hours*3600))
    diff = past_weight - @weight_now
    direction_verb = 'lost'
    if (diff < 0)
      diff = diff * -1
      direction_verb = "<span style='color:red'>gained</span>"
    end
    calories = number_with_precision(diff * 3500, :precision => 0)
    return "In the last #{hours_as_words} you #{direction_verb} #{number_with_precision(diff)} lbs (#{calories} calories)".html_safe
  end
  def goal_difference_as_string(goal_difference)
    user_id = session[:user_id]
    direction_verb = 'below'
    catch_up_string = ''
    if (goal_difference < 0)
      goal_difference = goal_difference * -1
      direction_verb = 'above'
      goal_loss_rate = User.filter_rate_loss(user_id).to_i
      lbs_per_second = goal_loss_rate / 3500.0 / 86400.0
      seconds_to_catch_up = goal_difference / lbs_per_second
      time_in_words = distance_of_time_in_words_to_now(Time.now + seconds_to_catch_up)
      catch_up_string = ". You can catch up in #{time_in_words}."
    end
    return "Your calculated weight is <span style='font-weight:bold'>#{number_with_precision(@diff)}</span> lbs #{direction_verb} your goal#{catch_up_string}".html_safe
  end
  def last_reading_as_string(last_reading)
    last_weight = last_reading.weight
    last_time = last_reading.reading_time
    time_ago_in_words = time_ago_in_words(last_time)
    return "Your last scale reading was <span style='font-weight:bold'>#{last_weight}</span> #{time_ago_in_words} ago".html_safe
  end
  def last_reading_goal_now_difference(last_reading, goal_now)
    last_weight = last_reading.weight
    difference = last_weight - goal_now
    difference_status = 'above'
    if ( difference <= 0 )
      difference_status = 'below'
      difference = difference * -1
    end
    return "Your scale reading is #{number_with_precision(difference, :precision => 2, :significant => true )} lbs #{difference_status} your goal"
  end
  def last_reading_weight_now_difference(last_reading, weight_now)
    last_weight = last_reading.weight
    difference = last_weight - weight_now
    difference_status = 'above'
    if ( difference <= 0 )
      difference_status = 'below'
      difference = difference * -1
    end
    return "Your scale reading is #{number_with_precision(difference, :precision => 2, :significant => true )} lbs #{difference_status} your calculated weight"
  end
end
