class Connection < ActiveRecord::Base
	attr_accessible :tag_id, :relative_id, :type, :relevance
	belongs_to :relative, :class => :tag
	belongs_to :tag
end
