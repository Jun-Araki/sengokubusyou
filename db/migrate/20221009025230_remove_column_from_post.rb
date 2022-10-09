class RemoveColumnFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :catch_copy, :string# rubocop:disable all
    remove_column :posts, :castle, :string
    remove_column :posts, :famous_battle, :string
    remove_column :posts, :recommend_point, :string
  end
end
