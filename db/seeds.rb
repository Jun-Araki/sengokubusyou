# rubocop:disable all
user1 = User.create!(email: "test1@example.com", password: "password", nickname: "sanamaru")
user2 = User.create!(email: "test2@example.com", password: "password", nickname: "taikou")
user3 = User.create!(email: "test3@example.com", password: "password", nickname: "osaka")

# post1 = Post.create!(name: "真田幸村", prefecture_name: "長野県", url: "https://ja.wikipedia.org/wiki/%E7%9C%9F%E7%94%B0%E4%BF%A1%E7%B9%81", image: File.open("./app/assets/images/Sanada_Yukimura.png"), user_id: 1)
# post2 = Post.create!(name: "徳川家康", prefecture_name: "愛知県", url: "https://ja.wikipedia.org/wiki/%E5%BE%B3%E5%B7%9D%E5%AE%B6%E5%BA%B7", image: File.open("./app/assets/images/Tokugawa_Ieyasu.png"), user_id: 2)
# post3 = Post.create!(name: "豊臣秀吉", prefecture_name: "愛知県", url: "https://ja.wikipedia.org/wiki/%E8%B1%8A%E8%87%A3%E7%A7%80%E5%90%89", image: File.open("./app/assets/images/Toyotomi_Hideyoshi.png"), user_id: 3)
# post4 = Post.create!(name: "織田信長", prefecture_name: "愛知県", url: "https://ja.wikipedia.org/wiki/%E7%B9%94%E7%94%B0%E4%BF%A1%E9%95%B7" ,image: File.open("./app/assets/images/Oda_Nobunaga.png"), user_id: 3)

# Like.create!(user_id: 1, post_id: 1)
# Like.create!(user_id: 1, post_id: 2)
# Like.create!(user_id: 1, post_id: 3)
# Like.create!(user_id: 2, post_id: 1)
# Like.create!(user_id: 3, post_id: 1)

# Comment.create!(post_id:1, user_id:2, content: "徳川家康の首まであと一歩。とても惜しかった。")
# Comment.create!(post_id:2, user_id:2, content: "長い江戸幕府の基礎を作った人")
# Comment.create!(post_id:3, user_id:2, content: "農民出身からのサクセスストーリー")
# Comment.create!(post_id:4, user_id:2, content: "前例をことごとく覆す")

# users = User.all
# user  = users.first
# following = users[1..2]
# followers = users[2..2]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

Rails.logger.debug "初期データの投入に成功しました！"
# rubocop:enable all