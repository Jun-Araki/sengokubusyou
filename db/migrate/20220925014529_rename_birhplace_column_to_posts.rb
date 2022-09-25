class RenameBirhplaceColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :birhplace, :birthplace
  end
end
