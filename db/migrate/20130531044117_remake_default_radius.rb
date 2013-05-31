class RemakeDefaultRadius < ActiveRecord::Migration
  def up
  	add_column :types, :default_radius, :float
  end

  def down
  	remove_column :types, :default_radius
  end
end
