class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.integer :atlas_id
    	t.string :name
      t.timestamps
    end
  end
end
