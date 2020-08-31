class Favorites

  attr_reader :favorite_pets
  def initialize(initial_favorite_pets)
    @favorite_pets = initial_favorite_pets ||= Array.new
  end

  def total
    @favorite_pets.count
  end

  def favorited?(pet_id)
    @favorite_pets.include?(pet_id.to_s)
  end

  def create_array
    @favorite_pets.map(&:to_i)
  end

  def details
    @favorite_pets.map{ |favorite| Pet.find(favorite) }
  end

  def pet_ids_to_objects(pet_ids)
    pet_ids.map{ |pet_id| Pet.find(pet_id) }
  end

  def pet_plucker
    PetAdoption.distinct.pluck(:pet_id)
  end

end
