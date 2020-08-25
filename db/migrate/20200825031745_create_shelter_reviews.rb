class CreateShelterReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :shelter_reviews do |t|
      t.string :title
      t.string :rating
      t.string :content
      t.string :image, default: "nil"
      
      t.timestamps
    end
  end
end
