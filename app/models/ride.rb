class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin


  validates_presence_of :pick_up_location,
                        :drop_off_location, 
                        :num_of_passengers



end
