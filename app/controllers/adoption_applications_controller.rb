class AdoptionApplicationsController < ApplicationController

  def new
  end

  def create
    require "pry"; binding.pry
    redirect_to "/favorites"
  end

end
