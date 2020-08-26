class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.shelter_reviews.create(review_params)
    if review.save
      flash[:success] = "Review successfully created"
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = "Review not created, please fill in a title, rating, and/or content"
      render :new
    end
  end

private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
