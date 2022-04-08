# require 'capybara/rspec'
require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  before :each do
    @user = User.create(email: 'johndoe@gmail.com', password: '123abc', name: 'John')
  end

  it 'displays an error and does not sign the user in' do
    visit '/users/sign_in'
    fill_in 'Username/Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_content('Invalid Username/Email or Password')
  end

  it 'displays an error for invalid credentials' do
    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'johndoe@gmail.com'
    fill_in 'Password', with: '123'
    click_button 'Log in'
    expect(page).to have_content('Invalid Username/Email or Password')
  end
end

 