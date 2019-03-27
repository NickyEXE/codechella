require 'spec_helper'
require 'rails_helper'

feature 'User can follow and unfollow a playlist' do
    scenario 'another user has created a playlist' do
      @user = FactoryBot.create(:user)
      @playlist = FactoryBot.create(:playlist_with_follows)
      sign_up_with 'MyString', 'MyString'
      login_with 'MyString', 'MyString'
      find_a_new_playlist
      follow_a_new_playlist
      
        expect(page).to have_content('Name')
        expect(page).to have_content('Description')
        expect(page).to have_content('Author')
      end

      scenario 'user has followed a playlist' do
        @user = FactoryBot.create(:user)
        @playlist = FactoryBot.create(:playlist_with_follows)
        sign_up_with 'MyString', 'MyString'
        login_with 'MyString', 'MyString'
        find_a_new_playlist
        follow_a_new_playlist
        expect(page).to have_content('Name')
        expect(page).to have_content('Description')
        expect(page).to have_content('Author')

        unfollow_a_new_playlist
        
          expect(page).to have_content('You\'re not')
        end
  
        def unfollow_a_new_playlist
          click_on 'Unfollow this Playlist'
          end

      def follow_a_new_playlist
        click_on 'Follow this Playlist'
        end
    
      def find_a_new_playlist
        click_on 'Find a new playlist'
      end
    
      def sign_up_with(dj_name, password)
        visit new_user_path
        fill_in 'user_dj_name', with: dj_name
        fill_in 'user_password', with: password
        click_button 'Create User'
      end
    
      def login_with(dj_name, password)
        visit login_path
        fill_in 'dj_name', with: dj_name
        fill_in 'password', with: password
        click_button 'Login'
      end
  end