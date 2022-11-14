class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name, index: true
      t.string :furigana_name
      t.integer :furigana_initial
      t.integer :prefecture_name
      t.string :commentary
      t.string :image
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
