class AtlasesController < ApplicationController
	def index
		@atlases = Atlas.all
	end
	def new
		@atlas = Atlas.new
		if request.post?
      redirect_to @atlas
    end
	end
	def create
		@atlas = Atlas.new(params[:atlas])
    @atlas.user_id = params[:user_id]
    @atlas.name = params[:name]
    @atlas.save
    count = (params[:type_count]).to_i
    i = 1
    count.times do
      param_name = "label" + i.to_s
      param_name = param_name.to_sym
      type = Type.new
      type.atlas_id = @atlas.id
      type.label = params[param_name]
      type.save
      i += 1
    end
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
