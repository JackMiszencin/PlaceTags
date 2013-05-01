class AddSizesToAtlas < ActiveRecord::Migration
  def change
  	add_column :atlases, :sizes, :array
  end
end
