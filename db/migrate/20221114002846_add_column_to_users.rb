class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :nickname
      t.string :user_image
      t.string :profile
      t.string :twitter
    end
  end
end
