class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  

  # def current_user
  #   begin
  #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #   rescue ActiveRecord::RecordNotFound
  #     @current_user = nil
  #   end
  # end

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
