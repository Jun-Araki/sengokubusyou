User.create!(email: "test1@example.com", password: "password", nickname: "さな丸")
User.create!(email: "test2@example.com", password: "password", nickname: "大江戸")
User.create!(email: "test3@example.com", password: "password", nickname: "戦国")
User.create!(email: "test4@example.com", password: "password", nickname: "天下布武")
User.create!(email: "test5@example.com", password: "password", nickname: "独眼竜")
User.create!(email: "test6@example.com", password: "password", nickname: "キリシタン大名")
User.create!(email: "test7@example.com", password: "password", nickname: "京")
User.create!(email: "test8@example.com", password: "password", nickname: "刀狩")
User.create!(email: "test9@example.com", password: "password", nickname: "鉄砲隊")
User.create!(email: "test10@example.com", password: "password", nickname: "天守閣")

require "csv"

CSV.foreach("db/csv_data/post_data.csv", headers: true) do |row|
  Post.create!(image: File.open("#{Rails.root}/db/fixtures/#{row['image']}"),
               name: row["name"],
               user_id: row["user_id"],
               prefecture_name: row["prefecture_name"],
               furigana_name: row["furigana_name"],
               furigana_initial: row["furigana_initial"],
               commentary: row["commentary"])
end

Rails.logger.debug "初期データの投入に成功しました！"
