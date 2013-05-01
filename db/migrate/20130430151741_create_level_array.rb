class CreateLevelArray < ActiveRecord::Migration
  def change
  	add_column :atlases, :level, :text
  end
end
