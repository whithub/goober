class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_current_ride, only: [:index]

  attr_accessor :completed_rides

  def index
    @rides = Ride.all
    @rides_count = current_admin.rides.count
    @completed_rides = current_admin.rides.where(status: 3)
  end

  def new
  end

  def ride_accepted
    @ride = Ride.find(params[:id])
    @ride.admin = current_admin
    @ride.ride_accepted!
    # @accepted_at = @ride.updated_at.strftime('%l:%M %P')
    redirect_to admins_rides_path, notice: "You've accepted a ride."
  end

  def picked_up
    @ride = Ride.find(params[:id])
    @ride.picked_up!
    redirect_to admins_rides_path
  end

  def dropped_off
    @ride = Ride.find(params[:id])
    @ride.dropped_off!
    @current_ride = ''
    redirect_to admins_rides_path
  end

  def completed_rides
    current_admin.rides.where(status: :complete)
  end

  private

  def set_current_ride
    @current_ride = current_admin.rides.last #find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:admin_id, :status)
  end
end
