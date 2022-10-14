class AddFuriganaToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :furigana, :string# rubocop:disable all
    add_column :posts, :furigana_initial, :string
    remove_column :posts, :url, :string
  end
end
