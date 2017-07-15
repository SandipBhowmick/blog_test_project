class AddImagePostToComments < ActiveRecord::Migration
  def change
    add_column :comments, :image_id, :string
  end
end
