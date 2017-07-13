class ChangeDefaultColumnValueToComments < ActiveRecord::Migration
  def change
  	change_column_default(:comments, :publish, false)
  end
end
