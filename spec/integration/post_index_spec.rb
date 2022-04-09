require 'rails_helper'

RSpec.describe 'Posts page', type: :feature do
  before :each do
    @user1 = User.create!(email: 'johndo@gmail.com', password: '123abc',
                          name: 'John', bio: 'Lorem Ipsum...',
                          photo: 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg')

    @user2 = User.create!(email: 'patrick@gmail.com', password: '123abc',
                          name: 'Patrick', bio: 'Lorem Ipsum...',
                          photo: 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg')

    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'johndo@gmail.com'
    fill_in 'Password', with: '123abc'
    click_button 'Log in'

    @post1 = @user1.posts.create!(title: 'testing1', text: 'i am here to write test cases 1', comments_counter: 0,
                                  likes_counter: 0)
    @post2 = @user1.posts.create!(title: 'testing2', text: 'i am here to write test cases 2', comments_counter: 0,
                                  likes_counter: 0)
    @post3 = @user1.posts.create!(title: 'testing3', text: 'i am here to write test cases 3', comments_counter: 0,
                                  likes_counter: 0)
    @post4 = @user1.posts.create!(title: 'testing4', text: 'i am here to write test cases 4', comments_counter: 0,
                                  likes_counter: 0)

    @post1.comments.create!(author: @user2, text: 'comment1')
    @post1.comments.create!(author: @user1, text: 'comment2')
    @post1.comments.create!(author: @user2, text: 'comment3')
    @post1.comments.create!(author: @user1, text: 'comment4')
    @post1.comments.create!(author: @user2, text: 'comment5')
    @post1.comments.create!(author: @user2, text: 'comment6')

    @post1.likes.create!(author: @user1)
    @post1.likes.create!(author: @user2)

    visit user_posts_path(@user1)
  end

  it "should have the user's profile picture" do
    image_url = page.find('img.user_image')['src']
    expect(image_url).to eq('https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg')
  end

  it "should be able to see user's name" do
    expect(page).to have_content('John')
  end

  it 'should display the number of posts' do
    expect(page).to have_content('Number of posts:4')
  end

  it "should display the posts' titles" do
    expect(page).to have_content('testing1')
    expect(page).to have_content('testing2')
    expect(page).to have_content('testing3')
    expect(page).to have_content('testing4')
  end

  it "should display some of the posts' body" do
    expect(page).to have_content('i am here to write test cases 1...')
    expect(page).to have_content('i am here to write test cases 2...')
    expect(page).to have_content('i am here to write test cases 3...')
    expect(page).to have_content('i am here to write test cases 4...')
  end

  describe 'Comments and Like' do
    it 'should display the how many comments a post has' do
      expect(page).to have_content('Comments: 6')
    end

    it 'should display the first comments of a post' do
      expect(page).to have_content('comment2')
      expect(page).to have_content('comment3')
      expect(page).to have_content('comment4')
      expect(page).to have_content('comment5')
      expect(page).to have_content('comment6')
    end

    it 'should display the number of likes a post has' do
      expect(page).to have_content('Likes: 2')
    end
  end

  it 'should show a section for pagination' do
    expect(page).to have_button('View more posts')
  end

  it 'should redirect me to a post show page when I click on it' do
    click_link('testing1')
    expect(current_path).to eq(user_post_path(@user1, @post1))
  end
end
