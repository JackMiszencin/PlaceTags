class AtlasesController < ApplicationController
	def index
		@atlases = Atlas.where(:user_id => current_user.id)
	end
	def new
		@atlas = Atlas.new
    @world = Atlas.where(:name => "World").first
		@atlas.types.build
    @atlas.build_realm
    @atlas.realm.build_type
	end
	def create
		@atlas = Atlas.new(params[:atlas])
    @atlas.save
    @atlas.types.first.set_levels
    redirect_to atlas_path(@atlas)
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
  	@reports = Report.where(:atlas_id => @atlas.id).includes(:tag)
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
