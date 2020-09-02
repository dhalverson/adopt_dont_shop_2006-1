class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :delete_all

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
end
