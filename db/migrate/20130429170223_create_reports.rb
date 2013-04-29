class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.timestamps
      t.string :location
      t.string :event
      t.integer	:event_id
      t.integer :tag_id
    end
  end
end
