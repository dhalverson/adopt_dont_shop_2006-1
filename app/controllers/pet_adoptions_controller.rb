class PetAdoptionsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def update
    @pet_adoption = PetAdoption.find(params[:pet_adoption_id])
    @pet = Pet.find(params[:pet_id])
    if @pet.status == "Pending" && @pet_adoption.status == "Pending"
      @pet_adoption.update(status: "Adoptable")
      @pet.update(status: "Adoptable")
      redirect_to "/applications/#{@pet_adoption.adoption_application_id}"
    elsif @pet.status == "Adoptable" && @pet_adoption.status == "Adoptable"
      @pet_adoption = PetAdoption.find(params[:pet_adoption_id])
      @pet_adoption.update(status: "Pending")
      @pet.update(status: "Pending")
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end
end
