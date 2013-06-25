class CasesController < ApplicationController
	def new
		@case = Case.new
		@atlas = Atlas.find_by_id(params[:atlas_id])
		@reports = Report.where(:atlas_id => @atlas.id)
	end

	def create
		@case = Case.new(params[:case])
		@case.save
		@case.add_reports(params["case_report_ids"])
		respond_to do |format|
      if @case.save
        format.html { redirect_to atlas_case_path(params[:atlas_id], @case.id), notice: 'Report was successfully updated.' }
        format.json { render json: atlas_case_path(params[:atlas_id], @case.id), status: :created, location: @case }
      else
        format.html { render action: "new" }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end

	end

	def show
		@case = Case.find_by_id(params[:id])
	end
end
