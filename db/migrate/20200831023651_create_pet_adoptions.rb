class CreatePetAdoptions < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_adoptions do |t|
      t.references :pet, foreign_key: true
      t.references :adoption_application, foreign_key: true
      t.timestamps
    end
  end
end
