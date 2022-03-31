require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'John Doe', photo: 'user.png', bio: 'Lorem ipsum dolor sit amet, consect')

  before { user.save }

  it 'name should be present' do
    user.name = nil
    expect(user).to_not_be_valid
    expect(user.errors.full_message[0]).to eq("Name can't be blank")
  end

  it 'posts_counter should be an integer' do
    user.posts_counter = 'aa'
    expect(user).to_not_be_valid
  end

  it 'posts_counter should be greater than or equal to zero' do
    user.posts_counter = -1
    expect(user).to_not_be_valid
  end
end