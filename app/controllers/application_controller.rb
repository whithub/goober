class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
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
      # flash[:error] = 'You must be logged in to perform this action.'
      redirect_to root_path, notice: 'You must be logged in to perform this action.'
      return false
    end
  end

end
