class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
   		t.string :business_name
    	t.string :location
      t.timestamps
    end
  end
end
