class PetsController < ApplicationController
  
  def index
    @pets = Pet.all
  end
  
  def show
    @pet = Pet.find(params[:id])
  end
  
  def new
    @shelter = Shelter.find(params[:id])
  end
  
  def create
    shelter = Shelter.find(params[:id])
    new_pet = shelter.pets.create(pet_params)
    if new_pet.valid?
      new_pet.save
      # flash[:success] = "#{@new_shelter.name} has been created..."
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      # flash[:error] = "#{@new_shelter.name} was not created due to missing information..."
      render :new
    end
  end
  
  private
  
  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end