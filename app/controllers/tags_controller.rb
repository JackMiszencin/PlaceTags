class TagsController < ApplicationController


	def index
		@atlas = Atlas.find_by_id(params[:atlas_id])
		if params[:search]
			@tags = Tag.search(params[:search], params[:atlas_id])
		else
			@tags = Tag.atlas(params[:atlas_id])
		end
	end
	def edit
		@tag = Tag.find(params[:id])
		@atlas = Atlas.find(params[:atlas_id])
		@sizes = Size.atlas(@atlas.id)
		@sizes.sort!{ |x, y| y.level <=> x.level}
	end
	def update
		@tag = Tag.find(params[:id])

		respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to atlas_tag_path(params[:atlas_id], params[:id]), notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
	end
	def show
		@tag = Tag.find(params[:id])
		@events = @tag.events.includes(:reports)
		@roles = @tag.roles.includes(:relative)
		@roles.sort!{ |r, t| t.relevance_score <=> r.relevance_score }
  	respond_to do |format|
  		format.html
  		format.json { render json: @tag }
  	end
  end
	def new
		@atlas = Atlas.find_by_id(params[:atlas_id])
		@sizes = Size.atlas(@atlas.id)
		@sizes.sort!{ |x, y| y.level <=> x.level}
		@tag = Tag.new
		respond_to do |format|
			format.html
			format.json { render json: @tag }
		end
	end
	def create
		@tag = Tag.new(params[:tag])
		@tag.atlas_id = params[:atlas_id]
		@relatives = Tag.atlas(params[:atlas_id])
		@tag.save
		@relatives.each do |r|
			@tag.build_connection(r)
		end
		@tag.save

		respond_to do |format|
      if @tag.save
        format.html { redirect_to atlas_tag_path(params[:atlas_id], @tag.id), notice: 'Report was successfully updated.' }
        format.json { render json: atlas_tag_path(params[:atlas_id], @tag.id), status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
	end

end
