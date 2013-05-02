class AddAtlasIdToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :atlas_id, :integer
  end
end
