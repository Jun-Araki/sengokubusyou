class AddFuriganaInitialPrefectureNameFromPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :furigana_initial, :integer# rubocop:disable all
    add_column :posts, :prefecture_name, :integer
  end
end
