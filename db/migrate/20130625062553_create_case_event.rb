class CreateCaseEvent < ActiveRecord::Migration
  def change
  	create_table :cases_events, :id => false do |t|
  		t.integer :case_id
  		t.integer :event_id
  	end
  	add_index :cases_events, [:case_id, :event_id]
  end
end
