module ApplicationHelper
  def footer
    if session[:user_id]
      user_id = session[:user_id]
      direction_word = "under"
      goal_difference = Reading.goal_difference(user_id)
      if ( goal_difference ) < 0
        goal_difference = goal_difference * -1
        direction_word = "above"
      end
      lbs_difference = number_with_precision(goal_difference, :precision => 2, :significant => true)
      calorie_difference = number_with_precision((goal_difference * 3500), :precision => 2, :significant => true)
      return ", #{direction_word} by #{lbs_difference} lbs (#{calorie_difference} cal)"
    else
      return "nil"
    end
  end
end
