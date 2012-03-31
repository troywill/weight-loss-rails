class ApplicationController < ActionController::Base
  before_filter :identify_user, :except => :login
  protect_from_forgery

  private
  def identify_user
    if cookies[:weight_loss_cookie]
      if User.find_by_email(cookies[:weight_loss_cookie])
        @user = User.find_by_email(cookies[:weight_loss_cookie])
        session[:user_id] = @user.id
        return
      end
    end
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
    else
      flash[:notice] = "Please log in"
      redirect_to :controller => :welcome, :action => :login
    end
  end

end
