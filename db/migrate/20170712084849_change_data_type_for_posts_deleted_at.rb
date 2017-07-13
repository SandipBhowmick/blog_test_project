class ChangeDataTypeForPostsDeletedAt < ActiveRecord::Migration
  def change
  	remove_column(:posts,:deleted_at)
  	add_column(:posts, :publish, :boolean, :default => true)
  end
end
