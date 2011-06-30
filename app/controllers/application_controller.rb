class ApplicationController < ActionController::Base
  before_filter :identify_user, :except => :login
  protect_from_forgery

  def identify_user
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
    else
      flash[:notice] = "Please log in"
      redirect_to :controller => :welcome, :action => :login
    end
  end
end
