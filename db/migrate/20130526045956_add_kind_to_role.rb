class AddKindToRole < ActiveRecord::Migration
  def change
  	add_column :roles, :kind, :string
  end
end
