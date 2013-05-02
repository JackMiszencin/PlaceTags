class Report < ActiveRecord::Base
	attr_accessible :location, :event, :atlas_id
	belongs_to :tag
	has_and_belongs_to_many :events
	belongs_to :atlas
  # attr_accessible :title, :body
end
