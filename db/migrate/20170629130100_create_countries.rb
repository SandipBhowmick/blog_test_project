class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
    	t.integer :user_id    	
    	t.string :country_name
    	t.timestamps null: false      
    end
  end
end
