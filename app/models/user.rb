class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :ride

  validates_presence_of :name, :phone_number
  validates_length_of :phone_number, minimum: 10, maximum: 10

end
