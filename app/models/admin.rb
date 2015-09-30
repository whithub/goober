class Admin < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :timeoutable, :lockable, :validatable

  has_one :ride

  validates_presence_of :name, :phone_number,
                        :car_make, :car_model,
                        :car_passenger_capacity
  validates_length_of :phone_number, minimum: 10, maximum: 10
  validates_numericality_of :car_passenger_capacity

end
