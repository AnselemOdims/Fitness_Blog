require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'John Doe', photo: 'user.png', bio: 'Lorem ipsum dolor sit amet, consect')
  post = Post.create(author: user, title: 'Proper Fitness', text: 'Lorem ipsum dolor sit amet, consect')
  comment = Comment.new(author: user, post: post, text: 'Good job')

  before { comment.save }

  it 'should create a comment' do
    expect(user.comments[0]).to eq(comment)
  end 

  it 'should increment comments_counter' do
    expect(comment.post.comments_counter).to eq 1
  end
end