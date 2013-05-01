class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
    	t.integer :atlas_id
    	t.integer :level
    	t.column :label, 'symbol', :null => false
      t.timestamps
    end
  end
end
