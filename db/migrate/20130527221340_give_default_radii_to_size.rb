class GiveDefaultRadiiToSize < ActiveRecord::Migration
  def up
  	add_column :sizes, :default_radius, :integer
  	add_column :sizes, :maximum_radius, :integer
  	add_column :sizes, :minimum_radius, :integer
  	change_column :sizes, :atlas_id, :integer, :nil => false
  	change_column :sizes, :level, :integer, :nil => false
  end

  def down
  	remove_column :sizes, :default_radius, :integer
  	remove_column :sizes, :maximum_radius, :integer
  	remove_column :sizes, :minimum_radius, :integer
  	change_column :sizes, :atlas_id, :integer, :nil => true
  	change_column :sizes, :level, :integer, :nil => true
  end
end
