class Case < ActiveRecord::Base
	attr_accessible :tag_id, :name, :atlas_id
	has_many :reports
	belongs_to :tag
	belongs_to :atlas
	has_and_belongs_to_many :events
	before_destroy :clear_reports
  # attr_accessible :title, :body

  def clear_reports
  	self.reports.each do |r|
  		r.case_id = nil
  		r.save
  	end
  end
  def add_report(report)
  	self.reports << report unless self.reports.include? report
 		self.events << report.event unless self.events.include? report.event
  	self.save
  end

  def add_reports(arry)
  	arry.each do |a|
  		self.add_report(Report.find_by_id(a.to_i))
  	end
  end

  def remove_report(report)
  	if self.reports.include? report
  		report.case_id = nil
  		report.save
  	end
  end

  def conflicts
  	messages = []
  	reps = self.reports.includes(:tag)
  	for i in (0...reps.length)
  		for c in ((i+1)...reps.length)
  			if reps[i].tag.get_type(reps[c].tag) == "none"
  				messages << "Tag '#{reps[i].tag.title}' has no common area with tag '#{reps[c].tag.title}'"
  			end
  		end
  	end
  	return messages
  end

  def conflicted?
  	return true if self.conflicts.length > 0
  	return false
  end

  def get_precise_location
  	if self.conflicts.length > 0
  		self.tag_id = nil
  	else
  		tags = self.reports.collect{|r| r.tag }.sort{|a,b| a.area <=> b.area}
 			self.tag_id = tags.first.id unless tags == []
 			self.save
  	end
  end

  def potential_reports
  	c = Case.includes(:events).find_by_id(self.id)
  	reports = Report.includes(:event).where(:case_id => nil, :atlas_id => c.atlas_id)
  	tag_ids = c.reports.collect{|r| r.tag_id}
    tag_ids = tag_ids.uniq! unless tag_ids.uniq! == nil
  	roles = Role.where(:relative_id => tag_ids, :tag_id => c.tag_id)
  	reports.sort{ |a,b| b.case_search_score(c, roles, tag_ids) <=> a.case_search_score(c, roles, tag_ids) }
  end

  def potential_cases
  	c = Case.includes(:events).find_by_id(self.id)
  	cases = Case.includes(:events, :reports).where(:atlas_id => self.atlas_id)
  	tag_ids = c.reports.collect{|r| r.tag_id}
    tag_ids = tag_ids.uniq! unless tag_ids.uniq! == nil
  	roles = Role.where(:relative_id => tag_ids, :tag_id => c.tag_id)
  	cases.sort{ |a,b| b.relation_score(c, roles, tag_ids) <=> a.relation_score(c, roles, tag_ids) }
  	cases = cases.to_a - [c]
  	return cases
  end

  def relation_score(c, roles, tag_ids)
    score = 0
    self.reports.includes(:event, :tag).each do |r|
    	score += r.case_search_score(c, roles, tag_ids)
    end
    return score
  end

end
