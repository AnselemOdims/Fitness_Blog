require "rails_helper"

RSpec.describe "Posts page", type: :feature do
  before :each do
    @user1 = User.create!(email: "johndo@gmail.com", password: "123abc",
                          name: "John", bio: "Lorem Ipsum...",
                          photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")

    @user2 = User.create!(email: "patrick@gmail.com", password: "123abc",
                          name: "Patrick", bio: "Lorem Ipsum...",
                          photo: "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg")

    visit "/users/sign_in"
    fill_in "Username/Email", with: "johndo@gmail.com"
    fill_in "Password", with: "123abc"
    click_button "Log in"

    @post1 = @user1.posts.create!(title: "testing1", text: "i am here to write test cases 1", comments_counter: 0,
                                  likes_counter: 0)

    @post1.comments.create!(author: @user2, text: "comment1")
    @post1.comments.create!(author: @user1, text: "comment2")
    @post1.comments.create!(author: @user2, text: "comment3")
    @post1.comments.create!(author: @user1, text: "comment4")
    @post1.comments.create!(author: @user2, text: "comment5")
    @post1.comments.create!(author: @user2, text: "comment6")

    @post1.likes.create!(author: @user1)
    @post1.likes.create!(author: @user2)

    visit user_post_path(@user1, @post1)
  end

  it "should show the post's title" do
    expect(page).to have_content("testing1")
  end

  it "should show the post's author" do
    expect(page).to have_content("John")
  end

  it "should display the how many comments a post has" do
    expect(page).to have_content("Comments: 6")
  end

  it "should display the number of likes a post has" do
    expect(page).to have_content("Likes: 2")
  end

  it "should display some of the post's body" do
    expect(page).to have_content("i am here to write test cases 1")
  end

  it "should display the username of each commenter on the post" do
    expect(page).to have_content("John")
    expect(page).to have_content("Patrick")
  end

  it "should display the comment each commentor left" do
    expect(page).to have_content("comment1")
    expect(page).to have_content("comment2")
    expect(page).to have_content("comment3")
    expect(page).to have_content("comment4")
    expect(page).to have_content("comment5")
    expect(page).to have_content("comment6")
  end
end
