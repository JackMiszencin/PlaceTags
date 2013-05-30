class Event < ActiveRecord::Base
  belongs_to :atlas
  has_and_belongs_to_many :reports

  def self.atlas(index)
  	where(:atlas_id => index)
  end
end
