class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_current_ride, only: [:index]

  layout 'admins'

  def index
    @rides = Ride.all
    @rides_count = current_admin.rides.count
    @completed_rides = current_admin.rides.where(status: 3)

    if request.xhr?
      render layout: false
    else
      render
    end
  end

  def new
  end

  def ride_accepted
    @ride = Ride.find(params[:id])
    @ride.admin = current_admin
    @ride.accepted_time = @ride.updated_at.strftime('%l:%M %P')
    @ride.ride_accepted!
    redirect_to admins_rides_path, notice: "You've accepted a ride."
  end

  def picked_up
    @ride = Ride.find(params[:id])
    @ride.pickup_time = @ride.updated_at.strftime('%l:%M %P')
    @ride.picked_up!
    redirect_to admins_rides_path
  end

  def dropped_off
    @ride = Ride.find(params[:id])
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
end
