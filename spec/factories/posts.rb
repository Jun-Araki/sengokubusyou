FactoryBot.define do
  factory :post do
    sequence(:name) { |n| "武将#{n}" }
    kana { "ぶしょう" }
    initial { "あ行" }
    prefecture { "東京都" }
    commentary { "テスト解説文です。" }
    association :user
  end
end
