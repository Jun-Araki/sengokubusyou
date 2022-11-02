User.create!(email: "test1@example.com", password: "password", nickname: "sanamaru")
User.create!(email: "test2@example.com", password: "password", nickname: "taikou")
User.create!(email: "test3@example.com", password: "password", nickname: "osaka")

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
