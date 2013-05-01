class ReCreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
    	t.integer :atlas_id
    	t.integer :level
    	t.string :label, :null => false
      t.timestamps
    end
  end
end
