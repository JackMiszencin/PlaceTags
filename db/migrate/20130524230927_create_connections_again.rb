class CreateConnectionsAgain < ActiveRecord::Migration
  def change
  	create_table :connections do |t|
  		t.timestamps
  		t.integer :tag_id
  		t.integer :relative_id
  		t.string :type
  		t.float :relevance
  	end
  end
end
