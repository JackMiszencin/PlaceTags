class Atlas < ActiveRecord::Base
	attr_accessible :user_id, :name, :types, :types_attributes, :type_count
	belongs_to :user
	has_many :sizes, :dependent => :destroy
  has_many :types, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  accepts_nested_attributes_for :types, :allow_destroy => true
  validates_presence_of :name, :message => "You must give a name to this atlas."
  
  def add_type
    t = Type.new
    self.types << t
  end
end
