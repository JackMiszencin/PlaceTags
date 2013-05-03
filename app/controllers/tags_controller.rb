class TagsController < ApplicationController
	def index
		@tags = Tag.all
	end
	def edit
		@tag = Tag.find(params[:id])
		@atlas = Atlas.find(params[:atlas_id])
		@sizes = Size.where(:atlas_id => @atlas.id)
	end
	def update
		@tag = Tag.find(params[:id])

		respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to atlas_report_path(params[:atlas_id], params[:id]), notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
	end

end
