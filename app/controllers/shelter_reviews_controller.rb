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
    @shelter = Shelter.find(params[:shelter_id])
    @review = ShelterReview.find(params[:review_id])
    if @review.update(review_params)
      flash[:success] = "Review successfully updated"
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = "Review not updated, please fill in a title, rating, and/or content"
      render :edit
    end
  end
  
  def destroy
    ShelterReview.destroy(params[:review_id])
    flash[:success] = "Review successfully deleted"
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
