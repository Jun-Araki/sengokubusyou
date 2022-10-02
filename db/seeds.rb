# frozen_string_literal: true

require "faker"
Faker::Config.locale = :ja

user = User.create!(email: "test3@example.com", password: "password")

# 1000件の初期データを投入
20.times do
  Post.create!(name: Faker::Name.name,
               catch_copy: Faker::Name.name,
               birthplace: Faker::Name.name,
               castle: Faker::Name.name,
               famous_battle: Faker::Name.name,
               recommend_point: Faker::Name.name,
               user_id: user.id)
end

users = User.all
user  = users.first
following = users[2..10]
followers = users[3..13]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Rails.logger.debug "初期データの投入に成功しました！"
