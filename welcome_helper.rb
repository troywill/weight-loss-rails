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
  def goal_difference_as_string
    user_id = session[:user_id]
    direction_verb = 'below'
    catch_up_string = ''
    if (@diff < 0)
      @diff = @diff * -1
      direction_verb = 'above'
      goal_loss_rate = User.filter_rate_loss(user_id).to_i
      lbs_per_second = goal_loss_rate / 3500.0 / 86400.0
      seconds_to_catch_up = @diff / lbs_per_second
      time_in_words = distance_of_time_in_words_to_now(Time.now + seconds_to_catch_up)
      catch_up_string = ". You can catch up in #{time_in_words}."
    end
    return "You are #{number_with_precision(@diff)} lbs #{direction_verb} your goal#{catch_up_string}".html_safe
  end
  def last_reading_as_string
    user_id = session[:user_id]
    last_reading = Reading.get_last_reading(user_id)
    last_weight = last_reading.weight
    last_time = last_reading.reading_time
    time_ago_in_words = time_ago_in_words(last_time)
    return "Your last measurement was #{last_weight} #{time_ago_in_words} ago"
  end
end
