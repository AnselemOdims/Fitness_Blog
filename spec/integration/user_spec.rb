require "rails_helper"

RSpec.describe "Users page", type: :feature do
  before :each do
    @user1 = User.create!(email: "johndo@gmail.com", password: "123abc", name: "John", bio: "Lorem Ipsum...", photo:"https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'johndo@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'
    
    # @user2 = User.create(email: "clark@gmail.com", password: "123abc", name: "clark", bio: "Lorem Ipsum...", photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    # @user3 = User.create(email: "emmastone@gmail.com", password: "123abc", name: "Emma", bio: "Lorem Ipsum...", photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    @user1.posts.create!(title: "testing", text: "i am here to write test cases", comments_counter: 0, likes_counter: 0)
    @user1.posts.create!(title: "testing2", text: "i am here to write test cases4", comments_counter: 0, likes_counter: 0)
    # @post3 = Post.create(author: @user2, title: "testing for another user", text: "I am here to find what happens to the missd gems")
    visit "/users"
  end

  it "expect to have all usernames for all users" do
    expect(page).to have_css("h2", text: "John")
  end

  it "expect to have user profile image" do
    image_url = page.find('img.user_image')['src']
    expect(image_url).to eql 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'
  end

  it "expect to have number of posts " do
    expect(page).to have_content("Number of posts:2")
  end

  it "expect on clicking on the user card it redirect to the user show page" do
    click_link "View User"
    expect(current_path).to eq(user_path(@user1))
  end
end
