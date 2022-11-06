class ChangeDatatypeFuriganaInitialOfPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :furigana_initial, "integer USING CAST(furigana_initial AS integer)"# rubocop:disable all
    change_column :posts, :prefecture_name, "integer USING CAST(prefecture_name AS integer)"# rubocop:disable all
  end
end
