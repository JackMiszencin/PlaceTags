class CleanUpSchema < ActiveRecord::Migration
  def up
  	drop_table :merchant_ratings
  	drop_table :merchants
  	drop_table :ratings
  	drop_table :songs
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
