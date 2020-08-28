class FavoritesController < ApplicationController

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
end
