class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_current_ride, only: [:index]

  def index
    @rides = Ride.all
    @rides_count = current_admin.rides.count
  end

  def new
  end

  # def update
  #   @ride = Ride.find(params[:id])
  #   @ride.admin = current_admin
  #
  #   if @ride.save #.update_attributes(ride_params)
  #     redirect_to admins_rides_path, notice: "You've accepted a ride."
  #   else
  #     flash.now[:alert] = @ride.errors.full_messages.join(", ")
  #   end
  # end

  def ride_accepted
    @ride = Ride.find(params[:id])
    @ride.admin = current_admin
    @ride.ride_accepted!
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
    @ride.destroy
    redirect_to admins_rides_path
  end


  private

  def set_current_ride
    @current_ride = current_admin.rides.first #find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:admin_id, :status)
  end
end
