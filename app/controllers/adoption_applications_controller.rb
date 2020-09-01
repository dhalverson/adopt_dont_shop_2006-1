class AdoptionApplicationsController < ApplicationController

  def new
    @favorites = favorite_pets.details
  end

  def create
    adoption_application = AdoptionApplication.create(application_params)
    if !adoption_application.save || !validate_pet_ids
      flash[:error] = "Please complete all the fields to submit the application"
      redirect_to "/adoption_applications/new"
    elsif adoption_application.save && validate_pet_ids
      flash[:success] = "Application succesfully submitted for selected pets"
      update_session(params[:pet_ids])
      pet_adoption_joins(params[:pet_ids], adoption_application)
      redirect_to "/favorites"
    end
  end
  
  def show
    @application = AdoptionApplication.find(params[:application_id])
  end


private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

  def validate_pet_ids
    return false if params[:pet_ids].nil? || params[:pet_ids].empty?
    params[:pet_ids].all? do |pet_id|
      Pet.exists?(pet_id)
    end
  end

  def update_session(pet_ids)
    pet_ids.each do |pet_id|
      session[:favorites].delete(pet_id)
    end
  end

  def pet_adoption_joins(pet_ids, adoption_application)
    pet_ids.each do |pet_id|
      PetAdoption.create(pet_id: pet_id, adoption_application_id: adoption_application.id)
    end
  end

end
