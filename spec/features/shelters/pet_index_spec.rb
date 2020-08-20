require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  before(:each) do
    @shelter_1 = Shelter.create({
            name: "Primary Shelter",
            address: "123 Maple Ave.",
            city: "Denver",
            state: "CO",
            zip: "80438"
            })
            
    @pet_1 = Pet.create(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Bailey",
              age: "3",
              sex: "Female",
              shelter_id: @shelter_1.id
              )
  end
  
  # it "I can see all pets by shelter" do
  #   visit "/shelters/#{@shelter_1.id}/pets"
  #
  #   expect(page).to have_content("Name: Bailey")
  #   expect(page).to have_content("Age: 3")
  #   expect(page).to have_content("Sex: Female")
  #
  # end
end
