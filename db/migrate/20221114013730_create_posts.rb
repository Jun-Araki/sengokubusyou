class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name, index: true
      t.string :kana
      t.integer :initial
      t.integer :prefecture
      t.string :commentary
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0

      t.timestamps
    end
  end
end
