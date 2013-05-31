class AddTypeCountToAtlas < ActiveRecord::Migration
  def change
  	add_column :atlases, :type_count, :integer, :nil => false, :default => 0
  end
end
