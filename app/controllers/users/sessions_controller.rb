class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    users_rides_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # def create
  #   super do |current_user|
  #     redirect_to users_rides_path(current_user)
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
