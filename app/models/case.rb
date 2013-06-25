class Case < ActiveRecord::Base
	attr_accessible :tag_id, :name, :atlas_id
	has_many :reports
	belongs_to :tag
	has_and_belongs_to_many :events
  # attr_accessible :title, :body

  def add_report(report)
  	self.reports << report
  	unless self.events.include? report.event
  		self.events << report.event
  	end
  	self.save
  end

  def conflicts
  	conflicts = []
  	reps = self.reports.includes(:tag)
  	for i in (0...reps.length)
  		for c in ((i+1)...reps.length)
  			if reps[i].tag.get_type(reps[c].tag) == "none"
  				conflicts << "Tag '#{reps[i].tag.title}' has no common area with tag '#{reps[c].tag.title}'"
  			end
  		end
  	end
  	return conflicts
  end

end
