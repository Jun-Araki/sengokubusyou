# rubocop:disable all
class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
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
    あ行: 1, か行: 2, さ行: 3, た行: 4, な行: 5,
    は行: 6, ま行: 7, や行: 8, ら行: 9, わ行: 10
  }

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

  enum prefecture_name: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
  }

  def self.select_prefecture_name(prefecture_name)
    case prefecture_name
    when "北海道"
      where(prefecture_name: "北海道")
    when "青森県"
      where(prefecture_name: "青森県")
    when "岩手県"
      where(prefecture_name: "岩手県")
    when "宮城県"
      where(prefecture_name: "宮城県")
    when "秋田県"
      where(prefecture_name: "秋田県")
    when "山形県"
      where(prefecture_name: "山形県")
    when "福島県"
      where(prefecture_name: "福島県")
    when "茨城県"
      where(prefecture_name: "茨城県")
    when "栃木県"
      where(prefecture_name: "栃木県")
    when "群馬県"
      where(prefecture_name: "群馬県")
    when "埼玉県"
      where(prefecture_name: "埼玉県")
    when "千葉県"
      where(prefecture_name: "千葉県")
    when "東京都"
      where(prefecture_name: "東京都")
    when "神奈川県"
      where(prefecture_name: "神奈川県")
    when "新潟県"
      where(prefecture_name: "新潟県")
    when "富山県"
      where(prefecture_name: "富山県")
    when "石川県"
      where(prefecture_name: "石川県")
    when "福井県"
      where(prefecture_name: "福井県")
    when "山梨県"
      where(prefecture_name: "山梨県")
    when "長野県"
      where(prefecture_name: "長野県")
    when "岐阜県"
      where(prefecture_name: "岐阜県")
    when "静岡県"
      where(prefecture_name: "静岡県")
    when "愛知県"
      where(prefecture_name: "愛知県")
    when "三重県"
      where(prefecture_name: "三重県")
    when "滋賀県"
      where(prefecture_name: "滋賀県")
    when "京都府"
      where(prefecture_name: "京都府")
    when "大阪府"
      where(prefecture_name: "大阪府")
    when "兵庫県"
      where(prefecture_name: "兵庫県")
    when "奈良県"
      where(prefecture_name: "奈良県")
    when "和歌山県"
      where(prefecture_name: "和歌山県")
    when "鳥取県"
      where(prefecture_name: "鳥取県")
    when "島根県"
      where(prefecture_name: "島根県")
    when "岡山県"
      where(prefecture_name: "岡山県")
    when "広島県"
      where(prefecture_name: "広島県")
    when "山口県"
      where(prefecture_name: "山口県")
    when "徳島県"
      where(prefecture_name: "徳島県")
    when "香川県"
      where(prefecture_name: "香川県")
    when "愛媛県"
      where(prefecture_name: "愛媛県")
    when "高知県"
      where(prefecture_name: "高知県")
    when "福岡県"
      where(prefecture_name: "福岡県")
    when "佐賀県"
      where(prefecture_name: "佐賀県")
    when "長崎県"
      where(prefecture_name: "長崎県")
    when "熊本県"
      where(prefecture_name: "熊本県")
    when "大分県"
      where(prefecture_name: "大分県")
    when "宮崎県"
      where(prefecture_name: "宮崎県")
    when "鹿児島県"
      where(prefecture_name: "鹿児島県")
    end
  end
end
  # rubocop:enable all