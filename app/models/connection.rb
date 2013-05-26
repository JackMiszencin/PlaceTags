class Connection < ActiveRecord::Base
	attr_accessible :tag_id, :relative_id, :type, :relevance
end
