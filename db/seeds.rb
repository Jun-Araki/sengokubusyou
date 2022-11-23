User.create!(email: "test1@example.com", password: "password", nickname: "さな丸",
             user_image: File.open("db/fixtures/Sanada_Yukimura.jpg"), twitter: "TS1engineer",
             profile: "真田幸村が大好きで、上田城などの史跡をめぐっています。戦国武将について語りたいので、ぜひよろしくお願いします。")
User.create!(email: "test2@example.com", password: "password", nickname: "大江戸", profile: "よろしくお願いします。",
             user_image: File.open("db/fixtures/hugaku.jpeg"))
User.create!(email: "test3@example.com", password: "password", nickname: "刀", profile: "よろしくお願いします。",
             user_image: File.open("db/fixtures/katana.jpg"))
User.create!(email: "test4@example.com", password: "password", nickname: "天下布武", profile: "よろしくお願いします。")
User.create!(email: "test5@example.com", password: "password", nickname: "独眼竜", profile: "よろしくお願いします。")
User.create!(email: "test6@example.com", password: "password", nickname: "キリシタン大名", profile: "よろしくお願いします。")
User.create!(email: "test7@example.com", password: "password", nickname: "雅", profile: "よろしくお願いします。")
User.create!(email: "test8@example.com", password: "password", nickname: "戦国", profile: "よろしくお願いします。")
User.create!(email: "test9@example.com", password: "password", nickname: "鉄砲隊", profile: "よろしくお願いします。")
User.create!(email: "guest@example.com", password: "password", nickname: "guest", profile: "よろしくお願いします。")

require "csv"

CSV.foreach("db/csv_data/post_data.csv", headers: true) do |row|
  Post.create!(image: File.open("#{Rails.root}/db/fixtures/#{row['image']}"),
               name: row["name"],
               kana: row["kana"],
               initial: row["initial"],
               prefecture: row["prefecture"],
               commentary: row["commentary"],
               user_id: row["user_id"])
end

10.times do |i|
  i += 1
  Like.create!(post_id: 93, user_id: i)
end
9.times do |i|
  i += 1
  Like.create!(post_id: 133, user_id: i)
end
8.times do |i|
  i += 1
  Like.create!(post_id: 137, user_id: i)
end
7.times do |i|
  i += 1
  Like.create!(post_id: 54, user_id: i)
end
6.times do |i|
  i += 1
  Like.create!(post_id: 116, user_id: i)
end
53.times do |i|
  i += 1
  Like.create!(post_id: i, user_id: 1)
end

2.upto(10) do |i|
  Relationship.create!(follower_id: 1, followed_id: i)
end
2.upto(10) do |i|
  Relationship.create!(follower_id: i, followed_id: 1)
end
3.upto(10) do |i|
  Relationship.create!(follower_id: 2, followed_id: i)
end

Comment.create!(user_id: 1, post_id: 93, content: "不遇の九度山時代から大坂の陣で大活躍したストーリーに感動した")
Comment.create!(user_id: 2, post_id: 93, content: "大坂の陣では圧倒的不利な中、徳川方を追い詰めたね")
Comment.create!(user_id: 3, post_id: 93, content: "大坂冬の陣では真田丸を築いて、ほぼ完璧にしのぎきったから凄いよ")
Comment.create!(user_id: 1, post_id: 93, content: "冬の陣の後に大坂城の堀が埋められなかったら、徳川政権も安泰でなかったと思うし")
Comment.create!(user_id: 2, post_id: 93, content: "でも大坂城の堀が埋められたから、夏の陣の勇姿があったということでもある")
Comment.create!(user_id: 1, post_id: 93, content: "夏の陣の決戦前の伊達政宗との戦いが激アツすぎる")
Comment.create!(user_id: 3, post_id: 93, content: "むしろ伊達勢を押してたし、普通に戦闘力あるよ")
Comment.create!(user_id: 1, post_id: 93, content: "夏の陣では家康が自害を決め込むほどの突撃だったんだよな")
Comment.create!(user_id: 4, post_id: 93, content: "本当にあと一歩だったけど、そういう姿に多くの人が感動するんだよね")

Comment.create!(user_id: 1, post_id: 54, content: "安土城跡に行ってきたけど、ここに天主閣があったと思うと感激")
Comment.create!(user_id: 5, post_id: 54, content: "確かに当時は滋賀の琵琶湖周辺が京に近くて栄えてたんだよね")

Comment.create!(user_id: 6, post_id: 116, content: "戦国最強の騎馬軍団")
Comment.create!(user_id: 7, post_id: 116, content: "もう少し長生きしていれば信長の天下にならなかったかもしれない")
