class ChangeDatatypeFuriganaInitialPrefectureNameOfPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :furigana_initial, :integer, using: "urigana_initial::integer"# rubocop:disable all
    change_column :posts, :prefecture_name, :integer, using: "prefecture_name::integer"# rubocop:disable all
  end
end
