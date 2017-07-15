class AddImagePostToPost < ActiveRecord::Migration
  def change
    add_column :posts, :image_id, :string
  end
end
