class Type < ActiveRecord::Base
	@@count = Type.all.length
	attr_accessible :atlas_id, :level, :label, :default_radius
	belongs_to :atlas
	has_many :tags
	after_create :increase_count
	after_create :set_default_radius
	after_destroy :decrease_count
	after_destroy :set_levels
	validates_presence_of :label, :message => "All types must be given a label."
	def set_default_radius
		self.default_radius = self.average_radius
		self.save
	end
	def set_levels
		types = Type.atlas(atlas_id).includes(:tags)
		types.sort! {|x,y| y.default_radius <=> x.default_radius}
		i = types.length
		types.each do |t|
			t.level = i
			t.save
			i -= 1
		end
	end
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
