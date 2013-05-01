class DestroySizeAndLevel < ActiveRecord::Migration
  def up
  	remove_column :atlases, :size, :string
  	remove_column :atlases, :level, :text 
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
