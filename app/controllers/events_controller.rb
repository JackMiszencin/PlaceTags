class EventsController < ApplicationController
	def index
		@events = Event.atlas(params[:atlas_id])
		@atlas = Atlas.find_by_id(params[:atlas_id])
	end
end
