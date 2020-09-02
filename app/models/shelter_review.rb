class ShelterReview < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title,
                        :rating,
                        :content
                        
  # def self.average(reviews)
  #   total = 0
  #   reviews.each do |review|
  #     total += review.rating.to_i
  #   end
  #   total / reviews.size
  # end
end
