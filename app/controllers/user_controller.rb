class UserController < ApplicationController
	before_filter :authenticate_user!
	
	def show
		@user = User.find(params[:id])
		@reviews = Review.where(user_id: current_user.id).order('id desc')
		@reviewed_buisnesses = rated_buisnesses(@reviews).uniq
	end

	private 

	def rated_buisnesses(reviews)

		reviews.inject([]) do |reviews, r|

			buisness = Business.find(r.business_id)
			rating = buisness.reviews.sum(:rating)
			ranked_stars = rating == 0 ? 0 : rating / buisness.reviews.count
			
			data = {
				id: buisness[:id],
				name: buisness.business_name,
				rating: rating, 
				reviews: buisness.reviews.count,
				location: buisness.location,
				ranked_stars: ranked_stars,
				unranked_stars: (5 - ranked_stars)
			}
			reviews << data
			
		end
	end
end
