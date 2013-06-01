class MakeDefaultRadiusZero < ActiveRecord::Migration
  def up
  	change_column :types, :default_radius, :float, :null => false, :default => 0.0
  end

  def down
  	change_column :types, :default_radius, :float, :nil => true
  end
end
