class DestroyMaximumAndMinimumRadius < ActiveRecord::Migration
  def up
  	remove_column :sizes, :minimum_radius
  	remove_column :sizes, :maximum_radius
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
