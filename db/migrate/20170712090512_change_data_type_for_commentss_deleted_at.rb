class ChangeDataTypeForCommentssDeletedAt < ActiveRecord::Migration
  def change
  	remove_column(:comments,:deleted_at)
  	add_column(:comments, :publish, :boolean, :default => true)
  end
end
