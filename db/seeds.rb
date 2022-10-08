# rubocop:disable all
user1 = User.create!(email: "test1@example.com", password: "password", nickname: "test1")
user2 = User.create!(email: "test2@example.com", password: "password", nickname: "test2")
user3 = User.create!(email: "test3@example.com", password: "password", nickname: "test3")

Post.create!(name: "真田幸村", catch_copy: "日本一の兵", birthplace: "信濃", castle: "上田城", famous_battle: "大坂の陣",
             recommend_point: "徳川家康にあと一歩のところまで迫った。その勇姿に多くの人が尊敬した。", image: File.open("./app/assets/images/Sanada_Yukimura.jpg"), user_id: 1)
Post.create!(name: "徳川家康", catch_copy: "東照大権現", birthplace: "三河", castle: "江戸城", famous_battle: "関ヶ原の戦い",
             recommend_point: "270年以上続いた江戸幕府の基盤を築いた", user_id: 2)
Post.create!(name: "豊臣秀吉", catch_copy: "太閤", birthplace: "尾張", castle: "大坂城", famous_battle: "山崎の戦い",
             recommend_point: "農民出身でありながら、関白まで出世して天下統一を果たした", user_id: 2)

users = User.all
user  = users.first
following = users[1..2]
followers = users[2..2]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Rails.logger.debug "初期データの投入に成功しました！"
# rubocop:enable all