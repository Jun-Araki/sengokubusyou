# frozen_string_literal: true

require "faker"
Faker::Config.locale = :ja

# 1000件の初期データを投入
50.times do
  Post.create!(name: Faker::Name.name,
               catch_copy: Faker::Name.name,
               birthplace: Faker::Name.name,
               castle: Faker::Name.name,
               famous_battle: Faker::Name.name,
               recommend_point: Faker::Name.name)
end

Rails.logger.debug "初期データの投入に成功しました！"
