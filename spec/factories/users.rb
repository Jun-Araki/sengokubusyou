FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password123" }
  end
end
