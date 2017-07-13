class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.integer :parent_id 
    	t.integer :user_id   	
    	t.string :name
		t.timestamps null: false
    end
  end
end
