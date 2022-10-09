class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments# rubocop:disable all

  validates :name, presence: true, length: { maximum: 30 }
  validates :catch_copy, presence: true, length: { maximum: 30 }
  validates :birthplace, presence: true, length: { maximum: 30 }
  validates :castle, presence: true, length: { maximum: 30 }
  validates :famous_battle, presence: true, length: { maximum: 30 }
  validates :recommend_point, presence: true, length: { maximum: 300 }
  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end
end
