class AddPrefectureToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :prefecture_name, :string# rubocop:disable all
    remove_column :posts, :prefecture_id, :integer
  end
end
