class SheltersController < ApplicationController
  
  def index
    @shelters = Shelter.all
  end
  
  def show
    @shelter = Shelter.find(params[:id])
  end
  
  def new
    
  end
  
  def create
    @new_shelter = Shelter.new(shelter_params)
    if @new_shelter.save
      flash[:success] = "#{@new_shelter.name} has been created..."
      redirect_to "/shelters"
    else
      flash[:error] = "Error: Please enter the following information and resubmit: #{missing_information.each {|k,v| k}}"
      redirect_to "/shelters/new"
    end
  end
  
  def edit
    @shelter = Shelter.find(params[:id])
  end
  
  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    if @shelter.save
      flash[:success] = "Information successfully updated."
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = "Error: Please enter the following information and resubmit: #{missing_information.each {|k,v| k}}"
      redirect_to "/shelters/#{@shelter.id}"
    end
  end
  
  def destroy
    @shelter = Shelter.find(params[:id])
    if pending_pets?
      flash[:error] = "Shelter cannot be deleted due to pending applications"
      redirect_to "/shelters/#{@shelter.id}"
    else
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    end
  end
  
  private
  
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
  
  def pending_pets?
    @shelter.pets.any? {|pet| pet.status == "Pending"}
  end
  
  def missing_information
    shelter_params.select {|key, value| value.nil? || value == ""}
  end
  
end