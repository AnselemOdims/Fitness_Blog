require "rails_helper"

RSpec.describe "Users page", type: :feature do
  before :each do
    @user1 = User.create!(email: "johndo@gmail.com", password: "123abc", name: "John", bio: "Lorem Ipsum...", photo:"https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @user2 = User.create!(email: "janedoe@gmail.com", password: "123abc", name: "Jane", bio: "Lorem Ipsum...", photo:"https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @user3 = User.create!(email: "peter@gmail.com", password: "123abc", name: "Peter", bio: "Lorem Ipsum...", photo:"https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    
    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'johndo@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'

    @user1.posts.create!(title: "testing", text: "i am here to write test cases", comments_counter: 0, likes_counter: 0)
    @user1.posts.create!(title: "testing2", text: "i am here to write test cases4", comments_counter: 0, likes_counter: 0)

    visit "/users"
  end

  it "should have all usernames for all users" do
    expect(page).to have_css("h2", text: "John")
    expect(page).to have_css("h2", text: "Jane")
    expect(page).to have_css("h2", text: "Peter")
  end

  it "should have user profile image" do
    image_url1 = page.all('img.user_image')[0]['src']
    image_url2 = page.all('img.user_image')[1]['src']
    image_url3 = page.all('img.user_image')[2]['src']
    expect(image_url1).to eql 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'
    expect(image_url2).to eql 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'
    expect(image_url3).to eql 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'
  end

  it "should have number of posts " do
    expect(page).to have_content("Number of posts:2")
  end

  it "expect on clicking on the user card it redirect to the user show page" do
    click_link "John"
    expect(current_path).to eq(user_path(@user1))
  end
end
