class Report < ActiveRecord::Base
	attr_accessible :event, :atlas_id, :event_name, :tag_id, :tag, :tag_attributes
	belongs_to :tag
	belongs_to :event
  belongs_to :case
  accepts_nested_attributes_for :tag
	belongs_to :atlas

  # attr_accessible :title, :body
  def format_date
    created_at.strftime("%B %d, %Y, %k:%M:%S %p")
  end
  def event_check
    self.save if self.id == nil
    @events = Event.where(:atlas_id => self.atlas_id)
    if self.event_id.nil? && !self.event_name.nil?
      @events.each do |ev|
        if self.event_name == ev.name
          self.event_id = ev.id
          self.save
          ev.save
          return
        else
        end
      end
      e = Event.new
      e.name = self.event_name
      e.atlas_id = self.atlas_id
      e.save
      self.event_id = e.id
      self.save
      return
    elsif !self.event_id.nil? && self.event_name.nil?
      self.event_name = self.event.name
      self.save
    elsif self.event_id.nil? && self.event_name.nil?
      self.destroy
    else
    end
  end

  def case_search_score(c, roles, tag_ids)
    score = 0
    if tag_ids != nil && tag_ids != []
      score += 1 if tag_ids.include? self.tag_id
      score += 1 if c.tag_id == self.tag_id
      roles.each do |r|
        score += r.relevance_score
      end
    end
    score += 1 if c.events.include? self.event
    return score
  end

end
