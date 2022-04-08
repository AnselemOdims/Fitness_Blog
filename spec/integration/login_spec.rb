# require 'capybara/rspec'
require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  before :each do
    @user = User.create(email: 'johndoe@gmail.com', password: '123abc', name: 'John', bio: 'Lorem Ipsum...')
    visit '/users/sign_in'
  end

  it 'should display the username, password and submit inputs' do
    expect(page).to have_field('Username/Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  it 'should display an error and does not sign the user in' do
    fill_in 'Username/Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_content('Invalid Username/Email or Password')
  end

  it 'should display an error for invalid credentials' do
    fill_in 'Username/Email', with: 'johndoe@gmail.com'
    fill_in 'Password', with: '123'
    click_button 'Log in'
    expect(page).to have_content('Invalid Username/Email or Password')
  end

  it 'should route to the root path and display flash message for valid credentials' do
    fill_in 'Username/Email', with: 'johndoe@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'
    expect(current_path).to eq(authenticated_root_path)
    expect(page).to have_content('Signed in successfully.')
  end
end
