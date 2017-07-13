class AddIsAdminToUser < ActiveRecord::Migration
  def change
  	add_column(:users, :is_admin, :boolean, :default => false)
  	add_column(:users, :is_approve, :boolean, :default => false)
  end
end
