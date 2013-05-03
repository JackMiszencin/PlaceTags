class GiveSizeIdToTag < ActiveRecord::Migration
  def up
  	remove_column :tags, :size
  	add_column :tags, :size_id, :integer
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
