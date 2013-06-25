class GiveCaseIdToReport < ActiveRecord::Migration
  def up
  	add_column :reports, :case_id, :integer
  end

  def down
  	remove_column :reports, :case_id
  end
end
