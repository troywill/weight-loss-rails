module ApplicationHelper

  def last_reading
    if ( session[:user_id] )
      user_id = session[:user_id]
      last_reading = Reading.last_reading(user_id)
      last_weight = last_reading.weight
      last_time = last_reading.reading_time
      last_time_string = time_ago_in_words( last_time )
#      return "Last reading: #{last_weight} (#{last_time_string} ago)<br />".html_safe
      return "#{last_weight}<br />".html_safe
    else
      return ''
    end
  end


  def get_start_weight
    if ( session[:user_id] )
      start_weight = Setting.get_start_weight(user_id)
      return start_weight
    else
      return 0
    end
  end
  
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
      return current_goal
    end
  end
  
  def milestone_string
    if session[:user_id]
      user_id = session[:user_id]

      s = Statistics.new(user_id)
      weight_now = s.weight_as_function_of_time(Time.now)
      weight_now_string = number_with_precision(weight_now, :precision => 2 )

      milestone_pre = "<div id='milestone'>\n"
      milestone_post = "</div>\n"
      # milestone_string = "Next milestone: "
      # if user_id == 2
      #   milestone_string += '275'
      # elsif user_id == 1
      #   milestone_string += '188'
      # else
      #   milestone_string = ''
      # end
      # milestone_string = "Calculated current weight: #{weight_now_string}\n"
      # TDW FEB 2011 => Make milestone_string a user setting
      milestone_string = "#{weight_now_string}<br />\n#{Reading.last_reading(user_id).weight}"
      milestone_string = milestone_pre + milestone_string + milestone_post
      return milestone_string.html_safe
    else
      return ""
    end
  end

  def header_string
    if session[:user_id]
      user_id = session[:user_id]
      current_goal = self.current_goal
      current_goal_string = number_with_precision(current_goal, :precision => 2 )
      last_weight = Reading.last_weight(session[:user_id])
      last_weight_string = number_with_precision(last_weight, :precision => 2 )
      if last_weight.nil?
        last_weight = 0
      end
      
      s = Statistics.new(user_id)
      weight_now = s.weight_as_function_of_time(Time.now)
      weight_now_string = number_with_precision(weight_now, :precision => 2 )

      # Draw a happy face if last_weight < current_goal
      # See http://commons.wikimedia.org/wiki/Category:SVG_smilies
      #  image_tag("icon.png", :size => "16x10", :alt => "Edit Entry")  # =>
      # if ( ( last_weight <= current_goal ) || ( weight_now <= current_goal ))
      if (( weight_now <= current_goal ))
        happy_face = image_tag('Csmile_alt.svg', :size => '20x20', :alt => 'Happy Face')
      else
        happy_face = image_tag('SadSmiley.svg', :size => '20x20', :alt => 'Sad Face')
      end

      diff = weight_now - current_goal
      big_mac = number_with_precision((diff * 3500 / 576).abs, :precision => 1 )
      big_mac = number_with_precision((diff).abs, :precision => 2 )
      if ( diff <= 0 )
        big_mac_string = "#{big_mac} #{happy_face}"
      else
        big_mac_string = "#{big_mac} above #{happy_face} ]"
        big_mac_string = "#{big_mac}"
      end

      # time_now_string = Time.now.strftime("%e-%a %l:%M %p") # => 17-Wed 3:34 PM
      time_now_string = Time.now.strftime("%l:%M %p %m/%d/%Y")
    else      
      return ""
    end
    return "<h1>#{current_goal_string}/#{big_mac_string} #{time_now_string}</h1>".html_safe
  end
end
