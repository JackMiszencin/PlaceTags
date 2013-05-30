class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
    	t.integer :level
    	t.string :label
    	t.integer :atlas_id
    	t.float :default_radius
      t.timestamps
    end
  end
end
