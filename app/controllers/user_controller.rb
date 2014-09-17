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
			rated_stars = rating == 0 ? 0 : rating / buisness.reviews.count
			unrated_stars = 5 - rated_stars

			data = {
				id: buisness[:id],
				name: buisness.business_name,
				rating: rating, 
				reviews: buisness.reviews.count,
				location: buisness.location,
				rated_stars: rated_stars,
				unrated_stars: unrated_stars
			}
			reviews << data
			
		end
	end
end
