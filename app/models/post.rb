class Post < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :catch_copy, presence: true, length: { maximum: 30 }
  validates :birthplace, presence: true, length: { maximum: 30 }
  validates :castle, presence: true, length: { maximum: 30 }
  validates :famous_battle, presence: true, length: { maximum: 30 }
  validates :recommend_point, presence: true, length: { maximum: 300 }
end
