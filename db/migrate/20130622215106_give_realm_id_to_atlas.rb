class GiveRealmIdToAtlas < ActiveRecord::Migration
  def up
  	add_column :atlases, :realm_id, :integer
  end

  def down
  	remove_column :atlases, :realm_id
  end
end
