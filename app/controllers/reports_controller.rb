class ReportsController < ApplicationController
	def index
		@reports = Report.all
	end
	def new
		@atlas = Atlas.find(params[:atlas_id])
		@report = Report.new
		@tags = Tag.atlas(params[:atlas_id])
		@types = Type.atlas(params[:atlas_id])
		if request.post?
			redirect_to @report
		end
	end

	def create
		@report = Report.new
		@atlas = Atlas.find_by_id(params[:atlas_id])
		@report.event_name = params[:event_name]
		@report.atlas_id = @atlas.id
		@report.save
		@report.event_check

		# This if logic tells us if the user is choosing an old or new tag
		# based on whether or not an input field is present. We've rigged it
		# to disappear and reappear based on what buttons the user pushes via
		# the reports.js file.
		if params[:old_tag_marker]
			@report.tag_id = params[:tags]
			@report.save
		else
			@tag = Tag.new
			#Assign new tag params to @tag
			@tag.lng = params[:lng]
			@tag.lat = params[:lat]
			@tag.title = params[:title]				
			@tag.radius = params[:radius]
			@tag.atlas_id = params[:atlas_id]
			@tag.type_id = params[:types]
			@tag.save
			# Above we save it to give it an id, and below we assign that id to report
			@report.tag_id = @tag.id
			@report.save
		end
		respond_to do |format|
			if @report.save
				format.html { redirect_to atlas_report_path(@atlas.id, @report) }
				format.json {render json: @report, status: :created, location: @report}
			else
				format.html { render action: "new" }
				format.json { render json: @report.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
    @report = Report.find(params[:id])
    @report.event_check
    @report.save
    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to atlas_report_path(params[:atlas_id], params[:id]), notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
  	@report = Report.find(params[:id])
  	@atlas = @report.atlas
  	respond_to do |format|
  		format.html
  		format.json { render json: @report }
  	end
  end

end
