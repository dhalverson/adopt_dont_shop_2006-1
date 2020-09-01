class PetAdoptionsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:pet_id])
    @pet_adoption = PetAdoption.find(params[:pet_adoption_id])
    @pet_adoption.update(status: "Pending")
    @pet.update(status: "Pending")
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
