class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @shelter.shelter_reviews.create(review_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
