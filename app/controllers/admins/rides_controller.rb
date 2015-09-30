class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    # @rides = Ride.all
  end

  def accept_ride
    set_ride
    @ride.ride_accepted!
    redirect_to admins_rides_path
  end

  def pick_rider_up
    set_ride
    @ride.picked_up!
    redirect_to admins_rides_path
  end

  def drop_rider_off
    set_ride
    @ride.dropped_off!
    redirect_to admins_rides_path
  end


  private

  def set_ride
    @ride = current_admin.rides.first #find(params[:id])
  end
end
