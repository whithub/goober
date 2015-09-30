require 'rails_helper'

describe "Admin", type: :feature do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:ride) { FactoryGirl.create(:ride) }

  before(:each) do
    login_as(admin, scope: :admin)
    ride.admin = admin
  end

  it 'can accept a ride successfully' do
    visit '/admins/rides'

    click_on "Accept"

    expect(current_path).to eq('/admins/rides')
    expect(page).to have_content("You've accepted a ride.")
  end

  it 'cannot have more than one ride request open' do
    visit '/admins/rides'
    click_on "Accept"

    expect(admin.rides.count).to eq(1)
    expect(page).to_not have_link('Accept')
  end

  it 'must complete a ride first before submitting for a new one' do
    visit '/admins/rides'
    click_on "Accept"

    expect(admin.rides.count).to eq(1)

    admin.rides.first.status = 'complete'

    expect(admin.rides.count).to eq(0)
    expect(page).to have_link('Accept')
  end
end
