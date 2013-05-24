class GiveRadiusToTag < ActiveRecord::Migration
  def up
  	add_column :tags, :radius, :float
  end

  def down
  	remove_column :tags, :radius
  end
end
