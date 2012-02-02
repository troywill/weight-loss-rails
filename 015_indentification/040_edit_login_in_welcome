#!/bin/bash
set -o errexit
source ./lib-rrp
WELCOME_CONTROLLER="${TOP_DIR}/app/controllers/welcome_controller.rb"

function edit_login_method () {

cat >> ${WELCOME_CONTROLLER} <<EOF
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

EOF

${EDITOR} ${WELCOME_CONTROLLER}

}

edit_login_method

exit
