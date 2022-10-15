class Furigana < ActiveHash::Base
  # rubocop:disable all
  self.data = [
    { ini: "あ行" }, { ini: "か行" }, { ini: "さ行" }, { ini: "た行" }, { ini: "な行" }, { ini: "は行" }, { ini: "ま行" }, { ini: "や行" }, { ini: "ら行" }, { ini: "わ行" }
  ]

  include ActiveHash::Associations
  has_many :posts
    # rubocop:enable all
end
