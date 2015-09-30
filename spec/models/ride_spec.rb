require 'rails_helper'

RSpec.describe Ride, type: :model do

  # let(:user) { FactoryGirl.create(:user) }
  let(:ride) { FactoryGirl.create(:ride) }

  it { is_expected.to validate_presence_of(:pick_up_location) }
  it { is_expected.to validate_presence_of(:drop_off_location) }
  it { is_expected.to validate_presence_of(:num_of_passengers) }

  it { is_expected.to belong_to(:admin) }
  it { is_expected.to belong_to(:user) }

  xit "has a default status of 'active' " do
    expect(ride.status).to eq('active')
  end

end
