class ReportsController < ApplicationController
	def index
		@reports = Report.all
	end
	def new
		@report = Report.new
		respond_to do |format|
			format.html
#			format.json { render json: @report }
		end
	end
	def create
		@report = Report.new(params[:report])
		@report.save
		if request.post?
			respond_to do |format|
				format.html { redirect_to @report }
				format.json {render json: @report, status: :created, location: @report}
			end
		else
			format.html { render action: "new" }
			format.json { render json: @report.errors, status: :unprocessable_entity }
		end
	end
	def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Atlas was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
  	@report = Report.find(params[:id])

  	respond_to do |format|
  		format.html
  		format.json { render json: @report }
  	end
  end

end
