class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  #protected####################################################
  protected

  def configure_permitted_parameters
    # binding.pry
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit({ roles: [] }, :email, :password, :remember_me, :authentication_token) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :authentication_token) }
  end
  
  def get_cookie_id
    return cookies.permanent[:cookie_id] ||= SecureRandom.uuid
  end
  
end
