class WelcomeController < ApplicationController
  def index
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
