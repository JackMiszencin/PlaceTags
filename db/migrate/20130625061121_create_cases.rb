class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
    	t.integer :atlas_id, :required => true
    	t.integer :tag_id
    	t.string :name
      t.timestamps
    end
  end
end
