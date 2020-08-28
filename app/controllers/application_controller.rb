class ApplicationController < ActionController::Base
  # attr_reader :
  protect_from_forgery with: :exception
  helper_method :favorite_pets

  def favorite_pets
    @favorite_pets ||= Favorites.new(session[:favorites])
  end
end
