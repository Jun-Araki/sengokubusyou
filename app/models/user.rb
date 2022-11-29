class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id", dependent: :destroy, inverse_of: :follower
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id", dependent: :destroy, inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :email, presence: true
  validates :profile, length: { maximum: 200 }

  mount_uploader :user_image, ImageUploader, uniqueness: true

  def self.guest
    find_or_create_by!(nickname: "guest", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(current_user)
    passive_relationships.any? { |relationship| relationship.follower_id == current_user.id }
  end
end
