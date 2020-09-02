class PetAdoption < ApplicationRecord

  belongs_to :pet
  belongs_to :adoption_application

  validates_presence_of :pet_id,
                        :adoption_application_id,
                        :status

end
