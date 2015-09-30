class Admins::RidesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @rides = Ride.all
    # @rides_count =
  end

  def new
  end

  def update
    @ride = Ride.find(params[:id])
    @ride.admin = current_admin

    if @ride.save #.update_attributes(ride_params)
      redirect_to admins_rides_path, notice: "You've accepted a ride."
    else
      flash.now[:alert] = @ride.errors.full_messages.join(", ")
    end
  end

  # def accept_ride
  #   set_ride
  #   @ride.ride_accepted!
  #   redirect_to admins_rides_path
  # end

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

  def ride_params
    params.require(:ride).permit(:admin_id)
  end
end
