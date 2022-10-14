class Furigana < ActiveHash::Base
  # rubocop:disable all
  self.data = [
    { id:1, ini: "あ" }, { id:2, ini: "か" }
  ]

  include ActiveHash::Associations
  has_many :posts
    # rubocop:enable all
end
