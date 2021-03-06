class Users::RidesController < ApplicationController
  before_filter :require_login
  before_action :set_current_ride, only: [:index]

  def new
    @ride = current_user.rides.new
  end

  def index
    @rides_count = current_user.rides.count
    @completed_rides = current_user.rides.completed

    if request.xhr?
      render layout: false
    else
      render
    end
  end

  def create
    @ride = current_user.rides.new(ride_params)

    if current_user.rides.not_complete.count == 0
      if @ride.save
        redirect_to users_rides_path, notice: "Ride has been requested."
      else
        flash[:alert] = @ride.errors.full_messages.join(', ')
        render :new
      end
    else
      redirect_to users_rides_path, notice: "You can only have one active ride at a time."
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:pick_up_location, :drop_off_location, :num_of_passengers)
  end

  def set_current_ride
    @current_ride = current_user.rides.last
  end

end
