class WelcomeController < ApplicationController
  def index
    user_id = session[:user_id]
    @readings = Reading.where( :user_id => user_id ).order('reading_time DESC')
    @settings = Setting.where( :user_id => user_id ).first
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:email])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index" )
      else
        flash.now[:notice] = "Unknown email"
      end
    end
  end

  def logout
    session[:user_id] = nil
  end
end
