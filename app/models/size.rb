class Size < ActiveRecord::Base
	attr_accessible :atlas_id, :level, :label
	belongs_to :atlas
	has_many :tags
	def self.atlas(index)
		where(:atlas_id => index)
	end
end
