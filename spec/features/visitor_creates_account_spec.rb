require 'spec_helper'
require 'rails_helper'

feature 'Visitor creates account' do
  scenario 'with valid dj name and password' do
    sign_up_with 'MyString', 'MyString'

    expect(page).to have_content('Logout')
  end

#   scenario 'with invalid email' do
#     sign_up_with 'invalid_email', 'password'

#     expect(page).to have_content('Sign in')
#   end

  def sign_up_with(dj_name, password)
    visit new_user_path
    fill_in 'user_dj_name', with: dj_name
    fill_in 'user_password', with: password
    click_button 'Create User'
  end
end