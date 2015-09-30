require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin) do
    Admin.create!(name: "Justin",
                  email: 'justin@example.com',
                  phone_number: '3030980980',
                  car_make: 'Chevy',
                  car_model: 'Aveo',
                  car_passenger_capacity: 4,
                  password: 'password',
                  password_confirmation: 'password')
  end

  it { is_expected.to validate_presence_of(:name) }

  it 'requires an email that is also unique' do
    is_expected.to validate_presence_of(:email)
    is_expected.to validate_uniqueness_of(:email)
  end

  it 'requires a phone number that is numerical and 10 digits long' do
    is_expected.to validate_presence_of(:phone_number)
    is_expected.to validate_length_of(:phone_number)
  end

  it 'errors if no phone number exists, if not numbers, and/or if not 10 digits long' do
    admin.phone_number = ''
    admin.should_not be_valid

    admin.phone_number = '1234'
    admin.should_not be_valid

    admin.phone_number = '12345678901234567890'
    admin.should_not be_valid

    admin.phone_number = '1234567890'
    admin.should be_valid
  end


  it { is_expected.to validate_presence_of(:car_make) }
  it { is_expected.to validate_presence_of(:car_model) }
  it { is_expected.to validate_presence_of(:car_passenger_capacity) }

  it { is_expected.to validate_numericality_of(:car_passenger_capacity) }


  it "should not be valid with an empty password" do
    admin.password = admin.password_confirmation = ""
    admin.should_not be_valid
  end

  it "should be valid with a new (valid) password" do
    admin.password = admin.password_confirmation = "new password"
    admin.should be_valid
  end

end
