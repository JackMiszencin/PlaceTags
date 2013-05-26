class AddRelativeIdToRole < ActiveRecord::Migration
  def change
  	add_column :roles, :relative_id, :integer
  end
end
