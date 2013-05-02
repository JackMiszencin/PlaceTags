class AtlasesController < ApplicationController
	def index
		@atlases = Atlas.all
	end
	def new
		@atlas = Atlas.new
		@atlas.user_id = 5 #Is this valid?!?!?
		respond_to do |format|
			format.html
			format.json { render json: @atlas }
		end
	end
	def create
		@atlas = Atlas.new(params[:atlas])
		@atlas.save
		if request.post?
			respond_to do |format|
				format.html { redirect_to @atlas }
				format.json {render json: @atlas, status: :created, location: @atlas}
			end
		else
			format.html { render action: "new" }
			format.json { render json: @atlas.errors, status: :unprocessable_entity }
		end
	end
	def update
    @atlas = Atlas.find(params[:id])

    respond_to do |format|
      if @atlas.update_attributes(params[:atlas])
        format.html { redirect_to @atlas, notice: 'Atlas was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @atlas.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
  	@atlas = Atlas.find(params[:id])
  	@reports = @atlas.reports

  	respond_to do |format|
  		format.html
  		format.json { render json: @atlas }
  	end
  end
  def destroy
  	@atlas = Atlas.find(params[:id])
  	@atlas.destroy
  	respond_to do |format|
  		format.html {redirect_to atlases_path}
  		format.json { head :no_content }
  	end
  end
end
