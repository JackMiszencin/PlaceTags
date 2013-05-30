class DestroyDefaultRadius < ActiveRecord::Migration
  def up
  	remove_column :types, :default_radius
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
