class ApplicationController < ActionController::Base
  helper_method :current_user, logged_in? # This makes our current_user and logged_in? methods visible and accesable for our controllers and all views. 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user # !! <-- convert current_user in a boolean
  end
end
