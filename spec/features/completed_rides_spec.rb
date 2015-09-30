require 'rails_helper'

describe "Completed ride", type: :feature do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user)  { FactoryGirl.create(:user) }

  before(:each) do
    ride = Ride.create(user_id: 9, admin_id: 6, status: 3,
                pick_up_location: "Denver",
                drop_off_location: "Boulder",
                num_of_passengers: 2,
                created_at: Time.now,
                accepted_time: '3:30pm',
                pickup_time: '3:38pm',
                dropoff_time: '3:58pm')

    ride.admin = admin
    ride.user = user

    login_as(admin, scope: :admin)
    login_as(user, scope: :user)
  end

  it 'info can be viewed on rider dashboard' do
    visit '/users/rides'

    # assert_selector('div', id: 'completed_rides', text: '')
    # within('#completed_rides').expect(page).to have_content("Denver")
  end


  it 'info can be viewed on driver dashboard' do
    visit '/admins/rides'

  end
end
