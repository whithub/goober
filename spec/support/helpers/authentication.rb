module Authentication

  module SessionHelpers
    def first_time_user_signin
      visit root_path
      click_on "Sign In as a Rider"
      click_on "Sign up"

      fill_in 'user_name', with: 'Justin'
      fill_in 'user_email', with: 'justin@example.com'
      fill_in 'user_phone_number', with: '3030980980'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_button "Sign up"
      click_on "Sign In as a Rider"
    end

    def user_sign_in
      User.create!(name: "Justin",
                   email: 'justin@example.com',
                   phone_number: '3030980980',
                   password: 'password',
                   password_confirmation: 'password')

      visit root_path
      click_on "Sign In as a Rider"

      fill_in 'user_email', with: 'justin@example.com'
      fill_in 'user_password', with: 'password'

      click_on "Log in"
    end
  end

end
