class Tag < ActiveRecord::Base
	belongs_to :atlas
	has_many :reports, :foreign_key => "tag_id"
  # attr_accessible :title, :body
end
