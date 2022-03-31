require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'John Doe', photo: 'user.png', bio: 'Lorem ipsum dolor sit amet, consect')
  post = Post.new(author: user, title: 'Proper Fitness', text: 'Lorem ipsum dolor sit amet, consect')

  before { post.save }

  it 'title should be present' do
    post.title = ''
    expect(post).to_not_be_valid
  end

  it 'title should be not be more than 250 characters' do
    post.title = 'title' * 300
    expect(post).to_not_be_valid
  end

  it 'comments_counter should be an integer' do
    post.comments_counter = 'aa'
    expect(post).to_not_be_valid
  end

  it 'comments_counter should be greater than or equal to zero' do
    post.comments_counter = -1
    expect(post).to_not_be_valid
  end

  it 'likes_counter should be an integer' do
    post.likes_counter = 'aa'
    expect(post).to_not_be_valid
  end

  it 'likes_counter should be greater than or equal to zero' do
    post.likes_counter = -1
    expect(post).to_not_be_valid
  end

  it 'should have a query limit of 5' do
    expect(post.recent_comments).to query_limit_eq(5)
  end

  it 'should increment posts_counter' do
    expect(post.author.posts_counter).to eq 1
  end
end
