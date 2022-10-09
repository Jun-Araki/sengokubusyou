class AddUrlToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :url, :string
  end
end
