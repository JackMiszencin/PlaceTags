class Tag < ActiveRecord::Base
	belongs_to :atlas
	has_many :reports, :foreign_key => "tag_id"
	belongs_to :size
	accepts_nested_attributes_for :size
	attr_accessible :size_attributes
  # attr_accessible :title, :body
end
