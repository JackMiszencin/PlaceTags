class DestroyAtlas < ActiveRecord::Migration
  def up
  	drop_table :atlas
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
