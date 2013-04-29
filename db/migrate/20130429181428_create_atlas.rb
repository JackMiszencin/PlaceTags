class CreateAtlas < ActiveRecord::Migration
  def change
    create_table :atlas do |t|
    	t.integer :user_id
      t.timestamps
    end
  end
end
