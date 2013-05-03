class GiveLocationToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :lng, :float
  	add_column :tags, :lat, :float
  end
end
