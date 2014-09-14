class MainController < ApplicationController
	def index
		buisness = Business.all
		@businesess = display_stars(buisness)
		
	end

	private
	
	def display_stars(buisness)
		buisness.inject([]) do |businesess, b|
			rating = b.reviews.sum(:rating)
			ranked_stars = rating / b.reviews.count
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
			businesess
		end
	end
end
