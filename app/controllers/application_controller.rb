class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   before_action :authenticate_user
  #  before_action :clear_active_record_query_cache

  # def clear_active_record_query_cache
  #   ActiveRecord::Base.connection.clear_query_cache
  # end
   before_action :require_login


    
   private

   def authenticate_user
    if controller_name == 'infos'
    if current_user.role == "admin"


    else

      redirect_to root_url
    end
  elsif controller_name == 'timechanges'
    if current_user.role == "superuser"
    else
      redirect_to root_url
    end
  end

  end

  private


  def require_login
    if current_user
      true

    else
  redirect_to '/users/new'
      
    end
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
helper_method :hello
def hello
  puts current_user.email
end 
end

