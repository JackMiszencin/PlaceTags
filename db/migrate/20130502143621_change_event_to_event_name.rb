class ChangeEventToEventName < ActiveRecord::Migration
  def up
  	remove_column :reports, :event
  	add_column :reports, :event_name, :string
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
