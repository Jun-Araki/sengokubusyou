class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_image, :string# rubocop:disable all
    add_column :users, :profile, :string
    add_column :users, :twitter, :string
  end
end
