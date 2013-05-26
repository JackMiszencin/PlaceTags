class Role < ActiveRecord::Base
  attr_accessible :name, :kind, :tag_id, :relative_id
  belongs_to :tag
  belongs_to :relative, :class_name => "Tag"
end
