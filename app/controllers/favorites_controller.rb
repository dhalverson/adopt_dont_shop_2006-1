class FavoritesController < ApplicationController

  def index
    @favorites = []
    favorite_pets.create_array.each do |pet|
      @favorites << Pet.find(pet)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    if favorite_pets.favorited?(pet_id_str)
      flash[:error] = "Error, #{pet.name} is already in your favorites!"
      redirect_to "/pets/#{pet.id}"
    else
      session[:favorites] ||= Array.new
      session[:favorites] << pet_id_str
      flash[:success] = "Success, #{pet.name} has been added to your favorites!"
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy
    if params[:pet_id] == "-1"
      session[:favorites] = []
      flash[:success] = "Success, all pets have been removed from your favorites!"
    else
      pet = Pet.find(params[:pet_id])
      session[:favorites].delete(pet.id.to_s)
      flash[:success] = "Success, #{pet.name} has been removed from your favorites!"
    end
    if URI(request.referer).path == "/favorites"
      redirect_to "/favorites"
    else
      redirect_to "/pets/#{pet.id}"
    end
  end
end
