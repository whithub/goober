class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
    devise_parameter_sanitizer.for(:sign_up) << :car_make
    devise_parameter_sanitizer.for(:sign_up) << :car_model
    devise_parameter_sanitizer.for(:sign_up) << :car_passenger_capacity
  end


  def logged_in?
    if current_user
      true
    else
      false
    end
  end

  def require_login
    unless logged_in?
      redirect_to root_path, notice: 'You must be logged in to perform this action.'
      return false
    end
  end

end
