class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true# rubocop:disable all
  validates :prefecture_id, presence: true
  validates :url, presence: true, uniqueness: true# rubocop:disable all
  mount_uploader :image, ImageUploader, uniqueness: true

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end
end
