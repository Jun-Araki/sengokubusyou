class RemoveFuriganaInitialPrefectureNameFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :furigana_initial, :string# rubocop:disable all
    remove_column :posts, :prefecture_name, :string
  end
end
