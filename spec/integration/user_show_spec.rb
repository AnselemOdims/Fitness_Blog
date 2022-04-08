require "rails_helper"

RSpec.describe "Users page", type: :feature do
  before :each do
    @user1 = User.create!(email: "johndo@gmail.com", password: "123abc", 
    name: "John", bio: "Lorem Ipsum...", 
    photo:"https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")
    
    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'johndo@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'
    
    @post1 = @user1.posts.create!(title: "testing", text: "i am here to write test cases", comments_counter: 0, likes_counter: 0)
    @post2 = @user1.posts.create!(title: "testing2", text: "i am here to write test cases4", comments_counter: 0, likes_counter: 0)
    @user1.posts.create!(title: "testing3", text: "i am here to write test cases4", comments_counter: 0, likes_counter: 0)

    visit user_path(@user1)
  end

  it "should have the user's profile picture" do
    image_url = page.find('img.user_image')['src']
    expect(image_url).to eq('https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg')
  end

  it "should be able to see user's name" do
    expect(page).to have_content('John')
  end

  it "should display the number of posts" do
    expect(page).to have_content("Number of posts:3")
  end

  it "should display the user's bio" do
    expect(page).to have_content("Lorem Ipsum..")
  end

  it "should display the user's first 3 posts" do
    expect(@user1.fetch_recent_posts.length).to eq(3)
  end

  it "should display a button that let's you view all user's posts" do
    expect(page).to have_button('See all posts')
  end

  it "should redirect to post's show page when i click on a post" do
    click_link 'testing2'
    expect(current_path).to eq(user_post_path(@user1, @post2))
  end

  it "should display a button that let's you view all user's posts" do
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end