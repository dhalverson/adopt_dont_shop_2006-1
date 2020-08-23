class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :image,
                        :name,
                        :age,
                        :sex
  def set_defaults
    self.status  ||= 'Adoptable'
  end
  
  def self.sort_by_status
    Pet.order(status: :asc)
  end

end