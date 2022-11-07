class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true# rubocop:disable all
  validates :furigana_name, presence: true
  validates :furigana_initial, presence: true
  validates :prefecture_name, presence: true
  validates :commentary, presence: true
  mount_uploader :image, ImageUploader, uniqueness: true

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end

  enum furigana_initial: {
    あ行: 1,
    か行: 2,
    さ行: 3,
    た行: 4,
    な行: 5,
    は行: 6,
    ま行: 7,
    や行: 8,
    ら行: 9,
    わ行: 10
  }

# rubocop:disable all
  def self.select_furigana_initial(furigana_initial)
    case furigana_initial
    when "あ行"
      where(furigana_initial: "あ行")
    when "か行"
      where(furigana_initial: "か行")
    when "さ行"
      where(furigana_initial: "さ行")
    when "た行"
      where(furigana_initial: "た行")
    when "な行"
      where(furigana_initial: "な行")
    when "は行"
      where(furigana_initial: "は行")
    when "ま行"
      where(furigana_initial: "ま行")
    when "や行"
      where(furigana_initial: "や行")
    when "ら行"
      where(furigana_initial: "ら行")
    when "わ行"
      where(furigana_initial: "わ行")
    end
  end
  # rubocop:enable all
end
