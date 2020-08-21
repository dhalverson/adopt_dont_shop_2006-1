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
  
  def edit
    @pet = Pet.find(params[:id])
  end
  
  def update
    pet = Pet.find(params[:id])
    missing_fields = pet_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      pet.update(pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      # flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| "#{field} "}}"
      redirect_to "/pets/#{params[:id]}/edit"
    end
  end
  
  private
  
  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end