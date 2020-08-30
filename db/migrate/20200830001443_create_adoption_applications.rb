class CreateAdoptionApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :adoption_applications do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :description
      t.timestamps
    end
  end
end
