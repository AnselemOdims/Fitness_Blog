class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'
  after_save :update_posts_counter

  private
  def update_posts_counter
    author.increment!(:posts_counter, by = 1)
  end
end