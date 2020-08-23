class Pet < ApplicationRecord
  belongs_to :shelter
  
  def self.sort_by_status
    Pet.order(status: :asc)
  end

end