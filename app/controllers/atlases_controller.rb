class AtlasesController < ApplicationController
	def index
		@atlases = Atlas.all
	end
end
