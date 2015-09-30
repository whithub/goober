class Admins::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    admins_rides_path
  end

end
