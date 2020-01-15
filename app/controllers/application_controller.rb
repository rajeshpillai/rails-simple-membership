class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    p current_user
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
  
  private
  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # Read from cookie now
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user  # this will make current_user availale in the view
end
