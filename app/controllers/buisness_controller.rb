class BuisnessController < ApplicationController
	def index
		if params[:search]
			buisness = Business.where("business_name LIKE ?", "%#{params[:search]}%").order('id desc')
		else
			buisness = Business.all.order('id desc')
		end
			@businesess = display_stars(buisness)
	end	

	def new
		@business = Business.new
	end

	def create

		@business = Business.new
		
		result = Business.create(business_params).valid?

		if result
			flash.now[:notice] = 'Business succefully added'
		else
			flash.now[:alert] = 'Error! Business not added.Fill in all fields'
		end

		render 'new'
	end

	def show

		@buisness = Business.find(params[:id])
		@reviews = @buisness.reviews.order('id desc')
		@reviews_count = @buisness.reviews.count
		@rated_stars = @reviews.blank? ? 0 : (@buisness.reviews.sum(:rating) / @reviews_count).to_i
		@unrated_stars = 5 - @rated_stars

	end
		
	private

	def business_params
		params.require(:business).permit( :business_name, :location)
	end

	def display_stars(buisness)
		buisness.inject([]) do |businesess, b|
			rating = b.reviews.sum(:rating)
			ranked_stars = rating == 0 ? 0 : rating / b.reviews.count
			data = {
				id: b.id,
				name: b.business_name,
				rating: rating, 
				reviews: b.reviews.count,
				location: b.location,
				ranked_stars: ranked_stars,
				unranked_stars: (5 - ranked_stars)
			}
			businesess << data
		end
	end
end
