class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :timeoutable, :lockable, :validatable

  validates_presence_of :name, :phone_number,
                        :car_make, :car_model,
                        :car_passenger_capacity
  validates_length_of :phone_number, minimum: 10, maximum: 10
  validates_numericality_of :car_passenger_capacity

end
