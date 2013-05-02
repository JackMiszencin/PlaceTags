class CreateEventsReports < ActiveRecord::Migration
  def up
  	create_table :events_reports, :id => false do |t|
  		t.references :event
  		t.references :report
  	end
  end

  def down
  	drop_table :events_reports
  end
end
