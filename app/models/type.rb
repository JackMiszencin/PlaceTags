class Type < ActiveRecord::Base
	@@count = Type.all.length
	attr_accessible :atlas_id, :level, :label, :default_radius
	belongs_to :atlas
	has_many :tags
	after_create :increase_count
	after_destroy :decrease_count
	def increase_count
		@@count +=1
	end
	def decrease_count
		@@count -=1
	end
	def self.count
		@@count
	end
	def average_radius
		radius_sum = 0
		tags = Tag.atlas(atlas_id).where(:type_id => id)
		if tags.length == 0
			return 0
		else
			tags.each do |t|
				radius_sum += t.radius
			end
			average = radius_sum/tags.length
			return average
		end
	end
	def self.atlas(index)
		where(:atlas_id => index)
	end
end
