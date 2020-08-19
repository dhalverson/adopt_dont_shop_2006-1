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
    if @new_shelter.valid?
      @new_shelter.save
      # flash[:success] = "#{@new_shelter.name} has been created..."
      redirect_to "/shelters"
    else
      # flash[:error] = "#{@new_shelter.name} was not created due to missing information..."
      render :new
    end
  end
  
  private
  
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
  
end