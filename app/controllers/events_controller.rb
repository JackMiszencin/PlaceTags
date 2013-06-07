class EventsController < ApplicationController
	def index
		@events = Event.atlas(params[:atlas_id]).includes(:tags)
		@atlas = Atlas.find_by_id(params[:atlas_id])
	end
	def show
		@event = Event.find_by_id(params[:id])
		@reports = Report.where(:event_id => @event.id).includes(:tag)
		@tags = @event.tags.includes(:type).uniq # Ensures lack of duplicates
	end
end
