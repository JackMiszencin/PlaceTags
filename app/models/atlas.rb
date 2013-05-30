class Atlas < ActiveRecord::Base
	attr_accessible :user_id, :name, :sizes, :sizes_attributes, :types, :types_attributes
	belongs_to :user
	has_many :sizes, :dependent => :destroy
  has_many :types, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :tags, :dependent => :destroy
	accepts_nested_attributes_for :sizes, :allow_destroy => true
  accepts_nested_attributes_for :types, :allow_destroy => true
  
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
      if self.types == []
        for i in (1..10)
          t = Type.new
          t.level = i
          t.label = ""
          self.types << t
        end
      else
      end

  	end
end
