FactoryBot.define do
  factory :post do
    name { Faker::Lorem.sentence }
  end
end
