class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin


  validates_presence_of :pick_up_location,
                        :drop_off_location, 
                        :num_of_passengers

  # enum status: { active: 0, accepted: 1, picked_up: 2, dropped_off: 3 }
  #
  #
  # include AASM
  # aasm column: :status, enum: true do
  #   state :active, :initial => true
  #   state :accepted
  #   state :in_transit
  #   state :complete
  #
  #   event :ride_accepted do
  #     transitions from: :active, to: :accepted
  #   end
  #
  #   event :picked_up do
  #     transitions from: :accepted, to: :picked_up
  #   end
  #
  #   event :dropped_off do
  #     transitions from: :picked_up, to: :complete
  #   end
  #
  # end

end
