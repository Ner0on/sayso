class ReviewController < ApplicationController
	def create

		comment = params[:comment]
		rating = params[:rating].to_i
		buisness_id = params[:buisness_id].to_i
		user_id = current_user.id
		
		Review.create(user_id: user_id, business_id: buisness_id, rating: rating, comment: comment )

		user_name = User.find(user_id).name

		render json: {
			comment: comment,
			rating: rating,
			buisness_id: buisness_id,
			user_name: user_name
		}

	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		
		redirect_to :back
	end
end
