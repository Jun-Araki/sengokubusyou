class AddColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image, :string
    add_reference :posts, :user, foreign_key: true
  end
end
