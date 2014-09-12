class MainController < ApplicationController
	def index
		@buisness = Business.all
	end

end
