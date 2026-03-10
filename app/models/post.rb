class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  PER_PAGE = 12

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :kana, presence: true
  validates :initial, presence: true
  validates :prefecture, presence: true
  validates :commentary, presence: true

  mount_uploader :image, ImageUploader

  enum initial: {
    あ行: 1, か行: 2, さ行: 3, た行: 4, な行: 5,
    は行: 6, ま行: 7, や行: 8, ら行: 9, わ行: 10
  }

  enum prefecture: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20, 岐阜県: 21, 静岡県: 22, 愛知県: 23,
    三重県: 24, 滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35, 徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46
  }

  scope :by_initial, ->(initial) { where(initial:) }
  scope :by_prefecture, ->(prefecture) { where(prefecture:) }

  scope :add_is_liked, lambda { |user|
    if user.present?
      sql = "LEFT OUTER JOIN likes ON likes.post_id = #{table_name}.id AND likes.user_id = ?"
      join_query = sanitize_sql_array([sql, user.id])
      joins(join_query).select(select_values.blank? && "#{table_name}.*", "likes.user_id IS NOT NULL AS is_liked")
    else
      select(select_values.blank? && "#{table_name}.*", "false AS is_liked")
    end
  }

  scope :with_like_flag, ->(user) { add_is_liked(user) }

  def self.search_with_initial(params)
    q = ransack(params[:q])
    posts_match = params[:initial].present? ? by_initial(params[:initial]) : q.result
    [q, posts_match]
  end

  def self.index_bundle(params, user)
    q, posts_match = search_with_initial(params)
    posts = build_list(posts_match, user, includes: [:user], order: { created_at: :asc }, page: params[:page])
    { q:, posts_match:, posts: }
  end

  def self.prefecture_bundle(params, user)
    posts_select = by_prefecture(params[:prefecture])
    posts = build_list(posts_select, user, includes: [:likes], order: nil, page: params[:page])
    post_display = prefecture_label(params[:prefecture])
    { posts_select:, posts:, post_display: }
  end

  def self.rankings_bundle(user)
    posts = includes(:likes).with_like_flag(user)
    likes = posts.find(top_ids_by_likes)
    comments = posts.find(top_ids_by_comments)
    { likes:, comments: }
  end

  def self.top_likes
    find(top_ids_by_likes)
  end

  def self.top_ids_by_likes(limit = 3)
    Like.group(:post_id).order("count(post_id) desc").limit(limit).pluck(:post_id)
  end

  def self.top_ids_by_comments(limit = 3)
    Comment.group(:post_id).order("count(post_id) desc").limit(limit).pluck(:post_id)
  end

  def self.prefecture_label(value)
    prefectures.invert.transform_keys!(&:to_s).fetch(value)
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.build_list(scope, user, includes:, order:, page:)
    relation = scope.includes(includes).with_like_flag(user)
    relation = relation.order(order) if order
    relation.page(page).per(PER_PAGE)
  end
  private_class_method :build_list
end
