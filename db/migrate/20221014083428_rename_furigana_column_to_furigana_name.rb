class RenameFuriganaColumnToFuriganaName < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :furigana, :furigana_name
  end
end
