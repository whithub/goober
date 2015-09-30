require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create!(name: "Justin",
                 email: 'justin@example.com',
                 phone_number: '3030980980',
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
    user.phone_number = ''
    user.should_not be_valid

    user.phone_number = '1234'
    user.should_not be_valid

    user.phone_number = '1234567890'
    user.should be_valid
  end

  it "should not be valid with an empty password" do
    user.password = user.password_confirmation = ""
    user.should_not be_valid
  end

  it "should be valid with a new (valid) password" do
    user.password = user.password_confirmation = "new password"
    user.should be_valid
  end

end
