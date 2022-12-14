require "csv"

class ImportCsv
  def self.import(path)
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        image: File.open("./app/assets/images/#{row['image']}"), name: row["name"], user_id: row["user_id"],
        prefecture: row["prefecture"], kana: row["kana"],
        initial: row["initial"], commentary: row["commentary"]
      }
    end
    list
  end

  def self.post_data
    list = import("db/csv_data/post_data.csv")

    Rails.logger.debug "インポート処理を開始"
    Post.create!(list)
    Rails.logger.debug "インポート完了!"
  end
end
