class AddCommentaryToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :commentary, :string
  end
end
