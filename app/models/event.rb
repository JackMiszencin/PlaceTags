class Event < ActiveRecord::Base
  belongs_to :atlas
  has_many :reports
  has_many :tags, :through => :reports
  has_and_belongs_to_many :cases

  def self.atlas(index)
  	where(:atlas_id => index)
  end

  def recent_reports(x) #Gives number of reports in last x hours.
  	tminus = x.hours.ago
  	count = 0
  	reports.each do |r|
  		if r.created_at > tminus
  			count += 1
  		end
  	end
  	return count
  end

end
