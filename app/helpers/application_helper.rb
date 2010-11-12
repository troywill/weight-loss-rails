module ApplicationHelper
      #        <%= 
      #   <% end %>

  def edit_settings
    if ( session[:user_id].nil? )
      return "nil"
    else
      return "#{link_to 'Settings', edit_setting_path(Setting.get_edit_id(session[:user_id]))}<br />".html_safe
    end
  end

end
