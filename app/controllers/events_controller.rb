class EventsController < ApplicationController
	def index
		@events = Event.atlas(params[:atlas_id])
		@atlas = Atlas.find_by_id(params[:atlas_id])
	end
	def show
		@event = Event.find_by_id(params[:id])
		@reports = Report.atlas(params[:atlas_id]).includes(:tag)
	end
end
