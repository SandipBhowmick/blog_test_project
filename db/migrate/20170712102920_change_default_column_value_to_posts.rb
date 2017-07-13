class ChangeDefaultColumnValueToPosts < ActiveRecord::Migration
  def change
  	change_column_default(:posts, :publish, false)
  end
end
