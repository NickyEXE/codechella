require 'spec_helper'
require 'rails_helper'

feature 'User creates a playlist' do
  scenario 'new user' do
    sign_up_with 'MyString', 'MyString'
    create_playlist 'MyPlaylist', 'This is a test playlist'

    expect(page).to have_content('MyPlaylist')
    expect(page).to have_content('This is a test playlist')
    expect(page).to have_content('This playlist has no songs on it.')
  end

  def create_playlist(name, description)
    click_on 'New Playlist'
    fill_in 'playlist_name', with: name
    fill_in 'playlist_description', with: description
    click_button 'Create Playlist'
  end

  def sign_up_with(dj_name, password)
    visit new_user_path
    fill_in 'user_dj_name', with: dj_name
    fill_in 'user_password', with: password
    click_button 'Create User'
  end
end