class CreateListings < ActiveRecord::Migration
  def change
  	create_table :listings do |t|
  		t.string :url, :added_by

  		t.belongs_to :group
  		
  		t.timestamps
  	end
  end
end
