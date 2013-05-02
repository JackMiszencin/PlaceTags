class Report < ActiveRecord::Base
	attr_accessible :location, :event, :atlas_id, :event_name
	belongs_to :tag
	has_and_belongs_to_many :events
	belongs_to :atlas
  # attr_accessible :title, :body
  def event_check
    @events = Event.all
    @events.each do |ev|
      if self.event_name == ev.name
        self.events << ev
        self.save
        ev.save
        return
      else
      end
    end
    e = Event.new
    e.name = self.event_name
    self.events << e
    self.save
    e.save
    return
    
  end

#  def event_check
#  check = self.event_loop
#  	if check
#  		return
#  	else
#  		e = Event.new
#  		e.name = self.event_name
#  		self.events << e
#      self.save
#      e.save
#  		return
#  	end
#  end
end
