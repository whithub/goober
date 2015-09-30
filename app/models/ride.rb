class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin


  validates_presence_of :pick_up_location,
                        :drop_off_location, 
                        :num_of_passengers

  enum status: { active: 0, accepted: 1, in_transit: 2, complete: 3 }


  include AASM
  aasm column: :status, enum: true do
    state :active, :initial => true
    state :accepted
    state :in_transit
    state :complete

    event :ride_accepted do
      transitions from: :active, to: :accepted
    end

    event :picked_up do
      transitions from: :accepted, to: :in_transit
    end

    event :dropped_off do
      transitions from: :in_transit, to: :complete
    end

  end

  def cost
    ((Time.parse(dropoff_time) - Time.parse(pickup_time))/60) * 3
  end


end
