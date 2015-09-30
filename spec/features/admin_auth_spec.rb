require 'rails_helper'

describe "AdminSessions", type: :feature do

  context "brand new user" do
    it "can sign up successfully" do
      visit '/'
      click_on "A Driver"
      click_on "Sign up"

      fill_in 'admin_name', with: 'Whitney'
      fill_in 'admin_email', with: 'whit@example.com'
      fill_in 'admin_phone_number', with: '3031234567'
      fill_in 'admin_car_make', with: 'Chevy'
      fill_in 'admin_car_model', with: 'Aveo'
      fill_in 'admin_car_passenger_capacity', with: 4
      fill_in 'admin_password', with: 'password'
      fill_in 'admin_password_confirmation', with: 'password'

      click_button "Sign up"

      expect(current_path).to eq('/admins/rides')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'errors out if email address has already been taken' do
      Admin.create!(name: "Justin",
                    email: 'justin@example.com',
                    phone_number: '3030980980',
                    car_make: 'Chevy',
                    car_model: 'Aveo',
                    car_passenger_capacity: 4,
                    password: 'password',
                    password_confirmation: 'password')

      visit '/'
      click_on "A Driver"
      click_on "Sign up"

      fill_in 'admin_email', with: 'justin@example.com'
      fill_in 'admin_password', with: 'password'
      fill_in 'admin_password_confirmation', with: 'password'

      click_button "Sign up"

      expect(page).to have_content('Email has already been taken')
    end
  end

  context "when user logs in" do
    describe "if user exists" do
      xit "logs in and logs out user successfully" do
        Admin.create!(name: "Justin",
                      email: 'justin@example.com',
                      phone_number: '3030980980',
                      car_make: 'Chevy',
                      car_model: 'Aveo',
                      car_passenger_capacity: 4,
                      password: 'password',
                      password_confirmation: 'password')

        visit '/admins/sign_in'
        fill_in 'admin_email', with: 'justin@example.com'
        fill_in 'admin_password', with: 'password'
        click_button "Log in"


        expect(current_path).to eq('/')
        #TODO expect(current_path).to eq('/admins/rides')
        # expect(page).to have_button('Accept A Ride')

        # click_on "Sign out"

        # expect(current_path).to eq(root_path)
      end
    end

    describe "if user does not exist" do
      it "returns error message" do
        visit '/admins/sign_in'
        fill_in 'admin_email', with: 'whitney@example.com'
        fill_in 'admin_password', with: 'password'
        click_button "Log in"

        page.should have_content "Invalid email or password."
      end
    end
  end
end
