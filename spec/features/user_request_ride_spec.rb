require 'rails_helper'

describe "User", :authentication, type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  it 'can request a ride successfully' do
    login_as(user, scope: :user)

    visit '/users/rides'
    click_on "Request A Ride"

    expect(current_path).to eq('/users/rides/new')

    fill_in 'ride_pick_up_location', with: 'Denver'
    fill_in 'ride_drop_off_location', with: 'Boulder'
    fill_in 'ride_num_of_passengers', with: 4
    click_on 'Request Ride'

    expect(current_path).to eq('/users/rides')
    expect(page).to have_content('Ride has been requested.')

  end

  it 'cannot have more than one ride request open' do
    login_as(user, scope: :user)
    visit '/users/rides'
    click_on "Request A Ride"

    expect(current_path).to eq('/users/rides/new')

    fill_in 'ride_pick_up_location', with: 'Denver'
    fill_in 'ride_drop_off_location', with: 'Boulder'
    fill_in 'ride_num_of_passengers', with: 4
    click_on 'Request Ride'

    expect(user.rides.count).to eq(1)
    expect(page).to_not have_button('Request A Ride')

    visit '/users/rides/new'

    fill_in 'ride_pick_up_location', with: 'Texas'
    fill_in 'ride_drop_off_location', with: 'Canada'
    fill_in 'ride_num_of_passengers', with: 2
    click_on 'Request Ride'

    expect(page).to have_content('You can only have one active ride at a time.')
    expect(user.rides.count).to eq(1)
  end



  it 'must complete a ride first before submitting for a new one' do
    login_as(user, scope: :user)
    visit '/users/rides'
    click_on "Request A Ride"
    fill_in 'ride_pick_up_location', with: 'Denver'
    fill_in 'ride_drop_off_location', with: 'Boulder'
    fill_in 'ride_num_of_passengers', with: 4
    click_on 'Request Ride'

    expect(page).to_not have_button('Request A Ride')

    login_as(admin, scope: :admin)
    visit '/admins/rides'
    click_link "Accept"
    click_on "Customer Picked Up"
    click_on "Customer Dropped Off"

    visit '/users/rides'
    expect(page).to have_content('Request A Ride')
  end
end
