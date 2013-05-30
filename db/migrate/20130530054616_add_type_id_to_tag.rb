class AddTypeIdToTag < ActiveRecord::Migration
  def change
  	add_column :tags, :type_id, :integer
  end
end
