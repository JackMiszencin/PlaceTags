class ReportsController < ApplicationController
	def index
		@reports = Report.all
	end
	def new
		@atlas = Atlas.find(params[:atlas_id])
		@report = Report.new
		@tags = Tag.atlas(params[:atlas_id])
		@types = Type.atlas(params[:atlas_id])
		@report.build_tag
		@report.tag.build_type

	end

	def create
		@report = Report.new(params[:report])
		@atlas = Atlas.find_by_id(params[:atlas_id])
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
