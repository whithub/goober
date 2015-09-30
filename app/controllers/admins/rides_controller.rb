class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_current_ride, only: [:index]

  layout 'admins'

  def index
    @rides = Ride.all
    @completed_rides = current_admin.rides.completed

    if request.xhr?
      render layout: false
    else
      render
    end
  end

  def ride_accepted
    find_ride
    @ride.admin = current_admin
    @ride.accepted_time = @ride.updated_at.strftime('%l:%M %P')
    @ride.ride_accepted!
    redirect_to admins_rides_path, notice: "You've accepted a ride."
  end

  def picked_up
    find_ride
    @ride.pickup_time = @ride.updated_at.strftime('%l:%M %P')
    @ride.picked_up!
    redirect_to admins_rides_path
  end

  def dropped_off
    find_ride
    @ride.dropoff_time = @ride.updated_at.strftime('%l:%M %P')
    @ride.dropped_off!
    @current_ride = ''
    redirect_to admins_rides_path
  end

  private

  def set_current_ride
    @current_ride = current_admin.rides.last
  end

  def ride_params
    params.require(:ride).permit(:admin_id, :status)
  end

  def find_ride
    @ride = Ride.find(params[:id])
  end
end
