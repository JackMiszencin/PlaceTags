class DestroySizes < ActiveRecord::Migration
  def up
  	drop_table :atlases
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
