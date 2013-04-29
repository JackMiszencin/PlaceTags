class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.timestamps
      t.string :title
      t.integer :size
      t.integer :atlas_id
    end
  end
end
