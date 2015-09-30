require 'rails_helper'

describe "Completed ride", type: :feature do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user)  { FactoryGirl.create(:user) }

  before(:each) do
    ride = Ride.create(user_id: 9,
                       admin_id: 6,
                       status: 3,
                       pick_up_location: "Denver",
                       drop_off_location: "Boulder",
                       num_of_passengers: 2,
                       created_at: Time.now,
                       accepted_time: '3:30pm',
                       pickup_time: '3:38pm',
                       dropoff_time: '3:58pm')

    ride.admin = admin
    ride.user = user
  end

  xit 'info can be viewed on rider dashboard' do
    login_as(user, scope: :user)
    visit '/users/rides'

    expect(page).to have_content('Completed Rides: 1')
    expect(page).to have_content('Cost $60.00')
  end


  xit 'info can be viewed on driver dashboard' do
    login_as(admin, scope: :admin)
    visit '/admins/rides'

  end
end
