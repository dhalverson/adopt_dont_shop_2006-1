class AdoptionApplication < ApplicationRecord

  has_many :pet_adoptions
  has_many :pets, through: :pet_adoptions

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :phone,
                        :description

end
