class ReRecreateAtlas < ActiveRecord::Migration
  def up
  	create_table :atlases do |t|
  		t.integer :user_id
  		t.string :name
   		t.timestamps
  	end
  end

  def down
  	drop_table :atlases
  end
end
