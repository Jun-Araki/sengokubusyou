class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments# rubocop:disable all

  validates :name, presence: true, length: { maximum: 30 }
  validates :birthplace, presence: true, length: { maximum: 30 }
  validates :url, presence: true
  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end
end
