class SerializeSizes < ActiveRecord::Migration
  def up
  	add_column :atlases, :size, :string
  end

  def down
  	remove_column :atlases, :size, :string
  end
end
