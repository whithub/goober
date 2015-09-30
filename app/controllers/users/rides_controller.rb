class Users::RidesController < ApplicationController
  before_filter :require_login
  before_action :set_current_ride, only: [:index]

  def new
    @ride = current_user.rides.new
  end

  def index
    # @requested_at = current_user.rides.first.created_at.strftime('%l:%M %P')
    @rides_count = current_user.rides.count
    @completed_rides = current_user.rides.where(status: 3)
  end

  def create
    @ride = current_user.rides.new(ride_params)

    if current_user.rides.count < 1
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

  def completed_rides
    current_user.rides.where(status: :complete)
  end

  # def cost
  #   ((Time.parse(ride.dropoff_time) - Time.parse(ride.pickup_time))/60) * 3
  # end

  private

  def ride_params
    params.require(:ride).permit(:pick_up_location, :drop_off_location, :num_of_passengers)
  end

  def set_current_ride
    @current_ride = current_user.rides.last #find(params[:id])
  end

end
