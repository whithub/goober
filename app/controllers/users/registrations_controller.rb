class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    users_rides_path
  end


end
