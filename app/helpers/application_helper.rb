module ApplicationHelper
  def edit_settings
    if ( session[:user_id].nil? )
      return "nil"
    else
      return "#{link_to 'Settings', edit_setting_path(Setting.get_edit_id(session[:user_id]))}<br />".html_safe
    end
  end

  def current_goal
    user_id = session[:user_id]
    if ( user_id.nil? )
      return 0
    else
      current_goal = Statistics.get_goal( user_id )
      return number_with_precision(current_goal, :precision => 2 )
    end
  end
  

  def header_string
    current_goal = self.current_goal
    last_weight = Reading.last_weight(session[:user_id])
    last_weight = number_with_precision(last_weight, :precision => 2 )
    if last_weight.nil?
      last_weight = 0
    end

    # Draw a happy face if last_weight < current_goal
    
    
    return "<h1>Goal: #{current_goal} | Last: #{last_weight}</h1>".html_safe
  end

end
