require 'rails_helper'

feature 'creating a playlist' do
  before do
    OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:spotify] = nil
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      :provider => 'spotify',
      :id => 'testing'
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
  end

  context 'on index page' do
    scenario 'displays a link to create playlist' do
      user = User.create(username: 'testing')
      visit '/users/index'
      click_link 'Sign in with Spotify'
      expect(page).to have_content "Welcome #{user.username}"
      expect(page).to have_link 'Generate playlist'
    end
  end

  # context 'clicking "Generate playlist" link on index page' do
  #   scenario 'displays playlist recommendations' do
  #     user2 = User.create(username: 'michael')
  #     visit '/users/index'
  #     click_link 'Generate playlist'
  #     expect(page).to have_content user2.username
  #     expect(page).to have_content 'Thriller'
  #     expect(current_path).to eq '/users/playlist'
  #   end
  # end
end
