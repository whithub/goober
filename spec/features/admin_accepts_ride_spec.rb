require 'rails_helper'

describe "Admin", type: :feature do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user)  { FactoryGirl.create(:user) }
  let(:ride)  { FactoryGirl.create(:ride) }


  before(:each) do
    login_as(user, scope: :user)
    ride.user = user

    login_as(admin, scope: :admin)
  end

  it 'can accept a ride successfully' do
    visit '/admins/rides'

    ride.admin = admin

    expect(admin.rides.count).to eq(1)
    expect(current_path).to eq('/admins/rides')
    # expect(page).to have_content("You've accepted a ride.")
  end

  it 'cannot have more than one ride request open' do
    visit '/admins/rides'
    click_on "Accept"

    expect(admin.rides.count).to eq(1)
    expect(page).to_not have_link('Accept')
  end

  xit 'must complete a ride first before submitting for a new one' do
    visit '/admins/rides'
    click_link "Accept"

    expect(admin.rides.count).to eq(1)

    click_on "Customer Picked Up"

    expect(page).to_not have_link('Accept')

    click_on "Customer Dropped Off"

    expect(admin.rides.count).to eq(0)
  end
end
