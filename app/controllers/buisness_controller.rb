class BuisnessController < ApplicationController
	
	def new
		@business = Business.new
	end

	def create

		@business = Business.new
		
		result = Business.create(business_params)

		if result
			flash.now[:notice] = 'Business succefully added'
		else
			flash.now[:alert] = 'Error! Business not added'
		end

		render 'new'
	end

	def show

		@buisness = Business.find(params[:id])
		@reviews = @buisness.reviews.order('id desc')
		@reviews_count = @buisness.reviews.count
		@rated_stars = (@buisness.reviews.sum(:rating) / @reviews_count).to_i
		@unrated_stars = 5 - @rated_stars

	end

	def add_review

		
	end
	
	private

	def business_params
		params.require(:business).permit( :business_name, :location)
	end
end
