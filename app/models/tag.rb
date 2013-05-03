class Tag < ActiveRecord::Base
	belongs_to :atlas
	has_many :reports, :foreign_key => "tag_id"
	belongs_to :size
  # attr_accessible :title, :body
end
