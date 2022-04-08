# require 'capybara/rspec'
require "rails_helper"

RSpec.describe "Users page", type: :feature do
  before :each do
    @user1 = User.create(email: "johndoe@gmail.com", password: "123abc", name: "John", bio: "Lorem Ipsum...", photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @user2 = User.create(email: "clark@gmail.com", password: "123abc", name: "clark", bio: "Lorem Ipsum...", photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @user3 = User.create(email: "emmastone@gmail.com", password: "123abc", name: "Emma", bio: "Lorem Ipsum...", photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @post1 = Post.create(author: @user1, title: "testing", text: "i am here to write test cases")
    @post2 = Post.create(author: @user1, title: "testing2", text: "i am here to write test cases4")
    @post3 = Post.create(author: @user2, title: "testing for another user", text: "I am here to find what happens to the missd gems")

    visit "/users"
  end

  it "expect to have all usernames for all users" do
    expect(rendered).to have_css("h2", text: "John")
    expect(rendered).to have_css("h2", text: "clark")
    expect(rendered).to have_css("h2", text: "Emma")
  end

  it "expect to have user profile image" do
    expect(page).to have_xpath("//img[contains(@src,'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg')]")
  end

  it "expect to have number of posts " do
    expect(page).to have_content("Number of posts:")
    expect(@user1.posts_counter).to eq(2)
    expect(page).to have_content("2")
    expect(@user2.posts_counter).to eq(1)
    expect(page).to have_content("1")
  end

  it "expect on clicking on the user card it redirect to the user show page" do
    
  end
end
