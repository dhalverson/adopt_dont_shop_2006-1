class PetAdoptionsController < ApplicationController
  
  def index
    @pet = Pet.find(params[:id])
  end
  
end