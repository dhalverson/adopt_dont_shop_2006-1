class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    if @pet.status == "Pending"
      @applications = PetAdoption.where(['pet_id = ? and status = ?', "#{@pet.id}", "Pending"])
    else
      @applications = PetAdoption.where(['pet_id = ? and status = ?', "#{@pet.id}", "Adoptable"])
    end
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    new_pet = shelter.pets.create(pet_params)
      if new_pet.valid?
        new_pet.save
        flash[:success] = "A new shelter has been created..."
        redirect_to "/shelters/#{shelter.id}/pets"
      else
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    missing_fields = pet_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      flash[:success] = "This shelter has been updated..."
      pet.update(pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      # flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| "#{field} "}}"
      # redirect_to "/pets/#{params[:id]}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == "Pending"
      flash[:error] = "Unable to delete this pet because it has an approved application"
      redirect_to "/pets/#{pet.id}"
    else
      session[:favorites].delete(params[:id]) if !session[:favorites].nil?
      Pet.destroy(params[:id])
      redirect_to "/pets"
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex, :status)
  end
end
