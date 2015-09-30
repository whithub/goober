require 'rails_helper'

describe "UserRequestRide", :authentication, type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  it 'can request a ride successfully' do
    login_as(user, scope: :user)

    visit '/users/rides'
    click_on "Request A Ride"

    expect(current_path).to eq('/users/rides/new')

  end

  it 'cannot have more than one ride request open'

  it 'must complete a ride first before submitting for a new one'
end
