class Report < ActiveRecord::Base
	belongs_to :tag
	has_and_belongs_to_many :events
	belongs_to :atlas
  # attr_accessible :title, :body
end
