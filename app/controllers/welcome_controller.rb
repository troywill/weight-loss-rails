class WelcomeController < ApplicationController
  def index
    user_id = session[:user_id]
    @readings = Reading.where( :user_id => user_id ).order('reading_time DESC')
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index" )
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
  end

  def settings
  end

  def graph
  end

  def goal
  end

  def meal
  end

  def sleep
  end

end
