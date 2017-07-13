class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :gender
    	t.integer :country_id
    	t.integer :state_id
    	t.json :interest
    	t.text :address
    	t.string :email
    	t.string :password
      t.timestamps null: false
    end
  end
end
