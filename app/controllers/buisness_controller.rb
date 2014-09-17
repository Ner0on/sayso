class BuisnessController < ApplicationController
	def index

		if params[:search]
			buisness = Business.search(params[:search]).order('id desc')
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

		raw_reviews = @buisness.reviews.order('id desc')
		@reviews = rebuild_reviews(raw_reviews)

		@reviews_count = @buisness.reviews.count
		@rated_stars = @reviews.blank? ? 0 : (@buisness.reviews.sum(:rating) / @reviews_count).to_i
		@unrated_stars = 5 - @rated_stars

	end
		
	private

	def business_params
		params.require(:business).permit( :business_name, :location)
	end

	def rebuild_reviews(raw_reviews)
		raw_reviews.inject([]) do |review, r|
			
			unrated_stars = 5 - r.rating

			data = {
				id: r.id,
				user_name: r.user.name,
				rated_stars: r.rating,
				unrated_stars: unrated_stars,
				created_at: r.created_at,
				user_id: r.user_id,
				comment: r.comment
			}

			review << data
		end		
	end

	def display_stars(buisness)
		buisness.inject([]) do |businesess, b|

			rating = b.reviews.sum(:rating)
			rated_stars = rating == 0 ? 0 : rating / b.reviews.count
			unrated_stars = 5 - rated_stars

			data = {
				id: b.id,
				name: b.business_name,
				rating: rating, 
				reviews: b.reviews.count,
				location: b.location,
				rated_stars: rated_stars,
				unrated_stars: unrated_stars
			}

			businesess << data
		end
	end
end
