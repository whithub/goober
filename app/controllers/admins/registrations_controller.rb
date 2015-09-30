class Admins::RegistrationsController < Devise::RegistrationsController


  def after_sign_up_path_for(resource)
    admins_rides_path
  end

end
