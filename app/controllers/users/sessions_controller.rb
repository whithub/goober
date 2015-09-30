class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    users_rides_path
  end

  def after_sign_up_path_for(resource)
    users_rides_path
  end

end
