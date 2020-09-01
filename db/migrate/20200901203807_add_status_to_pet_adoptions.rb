class AddStatusToPetAdoptions < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_adoptions, :status, :string, default: "Adoptable"
  end
end
