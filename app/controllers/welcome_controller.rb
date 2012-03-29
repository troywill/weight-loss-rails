class WelcomeController < ApplicationController
  def graph
  end

  def index
    u = User.find(session[:user_id])
    @goal_now = User.goal_now(u.id)
    @readings = Reading.by_user(session[:user_id]).order('reading_time DESC')
    @reading = Reading.new
    @weight_now = Reading.weight_at_time(u.id, Time.now)
    @diff = @goal_now - @weight_now

    # What was weight 1 hour ago
    @weight_one_hour = Reading.weight_at_time(u.id, Time.now-(3600))
    @one_hour_diff = @weight_one_hour - @weight_now
    
    # What was weight 12 hours ago
    @weight_twelve_hours = Reading.weight_at_time(u.id, Time.now-(3600*12))
    @twelve_hour_diff = @weight_twelve_hours - @weight_now

    # What was weight 24 hours ago
    @weight_yesterday = Reading.weight_at_time(u.id, Time.now-(86400))
    @yesterday_diff = @weight_yesterday - @weight_now

    # What was weight 3 days ago
    @weight_three_days = Reading.weight_at_time(u.id, Time.now-(86400*3))
    @three_days_diff = @weight_three_days - @weight_now
    
    # What was weight 7 days ago
    @weight_seven_days = Reading.weight_at_time(u.id, Time.now-(86400*7))
    @seven_days_diff = @weight_seven_days - @weight_now

    # Calculate rate loss over the last 28 days
    weight_now = Reading.weight_at_time(u.id, Time.now)
    weight_28 = Reading.weight_at_time(u.id, Time.now-(86400*28))
    @weight_diff = ( weight_now - weight_28 )
    # Figure out daily rate over the last 28 days
    @daily = @weight_diff * 3500 / 28
    
  end

  def login
    session[:user_id] = nil
    if request.post?
      if user = User.authenticate(params[:email])
        session[:user_id] = user.id
        # http://api.rubyonrails.org/classes/ActionDispatch/Cookies.html
        cookies[:weight_loss_cookie] = { :value => user.email, :expires => 1.month.from_now }
        redirect_to(:action => "index" )
      else
        flash.now[:notice] = "Unknown email"
      end
    end
  end

  def logout
    session[:user_id] = nil
    cookies.delete :weight_loss_cookie
  end

  def one_year_graph
  end

end
