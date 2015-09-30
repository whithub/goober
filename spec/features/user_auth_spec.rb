require 'rails_helper'

describe "UserSessions", type: :feature do

  context "brand new user," do
    it "can sign up successfully" do
      visit '/'
      click_on "A Rider"
      click_on "Sign up"

      fill_in 'user_name', with: 'Justin'
      fill_in 'user_email', with: 'justin@example.com'
      fill_in 'user_phone_number', with: '3030980980'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_button "Sign up"

      expect(current_path).to eq(root_path)
      #TODO expect(current_path).to eq('/users/rides')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'errors out if email address has already been taken' do
      User.create!(name: "Justin",
                   email: 'justin@example.com',
                   phone_number: '3030980980',
                   password: 'password',
                   password_confirmation: 'password')

      visit '/'
      click_on "A Rider"
      click_on "Sign up"

      fill_in 'user_email', with: 'justin@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_button "Sign up"

      expect(page).to have_content('Email has already been taken')
    end
  end


  context "when user logs in," do
    describe "if user exists," do
      it "logs in and logs out user successfully" do
        User.create!(name: "Justin",
                     email: 'justin@example.com',
                     phone_number: '3030980980',
                     password: 'password',
                     password_confirmation: 'password')

        visit '/users/sign_in'
        fill_in 'user_email', with: 'justin@example.com'
        fill_in 'user_password', with: 'password'
        click_button "Log in"

        expect(current_path).to eq('/users/rides')
        expect(page).to have_link('Request A Ride')

        click_link "Sign out"

        expect(current_path).to eq(root_path)
      end
    end

    describe "if user does not exist" do
      it "returns error message" do
        visit '/users/sign_in'
        fill_in 'user_email', with: 'whitney@example.com'
        fill_in 'user_password', with: 'password'
        click_button "Log in"

        page.should have_content "Invalid email or password."
      end
    end
  end
end
