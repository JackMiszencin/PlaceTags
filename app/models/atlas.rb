class Atlas < ActiveRecord::Base
	attr_accessible :user_id, :name, :sizes, :sizes_attributes
	belongs_to :user
	has_many :sizes
  has_many :reports
	accepts_nested_attributes_for :sizes, :allow_destroy => true
  
  after_initialize :init
  	def init
      if self.sizes == []
  		  for i in (1..10)
  		    s = Size.new
  		    s.level = i
  		    s.label = ""
  		    self.sizes << s
  		  end
      else
      end
  	end
end
