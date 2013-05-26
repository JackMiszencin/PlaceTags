class AddTagIdToRole < ActiveRecord::Migration
  def change
  	add_column :roles, :tag_id, :integer
  end
end
