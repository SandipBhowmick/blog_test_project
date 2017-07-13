class AddFollowCountToUser < ActiveRecord::Migration
  def change
  	add_column :users, :follow_count, :integer
  end
end
