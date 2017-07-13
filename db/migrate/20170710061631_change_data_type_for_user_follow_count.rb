class ChangeDataTypeForUserFollowCount < ActiveRecord::Migration
  def change
  	change_column(:users, :follow_count, :integer, :default => 0)
  end
end
