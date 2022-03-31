require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'John Doe', photo: 'user.png', bio: 'Lorem ipsum dolor sit amet, consect')
  post = Post.create(author: user, title: 'Proper Fitness', text: 'Lorem ipsum dolor sit amet, consect')
  like = Like.new(author: user, post: post)

  before { like.save }

  it 'should create a new like' do
    expect(user.likes[0]).to eq(like)
  end

  it 'should increment likes_counter' do
    expect(like.post.likes_counter).to eq 1
  end
end
