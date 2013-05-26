class AddRelevanceScoreToRole < ActiveRecord::Migration
  def change
  	add_column :roles, :relevance_score, :float
  end
end
