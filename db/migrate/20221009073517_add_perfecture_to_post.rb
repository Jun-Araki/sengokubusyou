class AddPerfectureToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :prefecture_id, :integer# rubocop:disable all
    remove_column :posts, :birthplace, :string
  end
end
