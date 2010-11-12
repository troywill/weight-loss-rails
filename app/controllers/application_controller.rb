class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :identify_user, :except => :login

  def identify_user
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
    else
      flash[:notice] = "Please log in"
      redirect_to :controller => :welcome, :action => :login
    end
  end
  
end
