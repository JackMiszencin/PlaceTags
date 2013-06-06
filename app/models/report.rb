class Report < ActiveRecord::Base
	attr_accessible :event, :atlas_id, :event_name
	belongs_to :tag
	has_and_belongs_to_many :events
	belongs_to :atlas
  # attr_accessible :title, :body
  def event_check
    self.save if self.id == nil
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
    e.atlas = self.atlas
    self.events << e
    self.save
    e.save
    return  
  end

end
