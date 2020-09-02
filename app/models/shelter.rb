class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :delete_all

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
                        
  def total_applications
    PetAdoption.joins(:pet).where('pets.shelter_id = ?', id).count
  end
end
