class DestroyLocation < ActiveRecord::Migration
  def up
  	remove_column :reports, :location
  end

  def down
  	add_column :reports, :location, :string
  end
end
