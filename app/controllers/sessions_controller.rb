class SessionsController < ApplicationController
  skip_before_action :require_login
  def create

    user = User.from_omniauth(request.env["omniauth.auth"])
    puts request.env["HTTP_REFERER"]
    if user != nil && user.status == "1"
    session[:user_id] = user.id
    flash.now[:notice] = "successfully signed in "

     redirect_to moduls_path
else
 
   
  session[:http] = request.env["HTTP_REFERER"]
  
  redirect_to new_user_path
 

  
end
  end


  def destroy
    session[:user_id] = nil


   session[:act] = "#{controller_name}/#{action_name}"
   puts session[:act]
    redirect_to root_path
  end
end