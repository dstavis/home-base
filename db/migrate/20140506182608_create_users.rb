class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :email, :picture_url
  		t.integer :facebook_id
  	end
  end
end
