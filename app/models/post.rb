class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  has_many :likes, foreign_key: 'post_id', dependent: :destroy
  after_save :update_posts_counter
  validates :title, presence: { message: 'Please make sure your post has a title'}, length: { maximum: 250 }
  validates :text, presence: { message: 'Kindly add a descriptive text for this post'}
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order('created_at DESC').limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
