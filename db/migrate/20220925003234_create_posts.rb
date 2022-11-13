# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.index :name
      t.string :catch_copy
      t.string :birhplace
      t.string :castle
      t.string :famous_battle
      t.text :recommend_point

      t.timestamps
    end
  end
end
