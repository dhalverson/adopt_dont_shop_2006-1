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
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = ShelterReview.find(params[:review_id])
  end

  def update
    review = ShelterReview.update(review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
