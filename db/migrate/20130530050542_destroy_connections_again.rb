class DestroyConnectionsAgain < ActiveRecord::Migration
  def up
  	drop_table :connections
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
