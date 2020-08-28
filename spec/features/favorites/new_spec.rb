# User Story 9, Favorite Creation
#
# As a visitor
# When I visit a pet's show page
# I see a button or link to favorite that pet
# When I click the button or link
# I'm taken back to that pet's show page
# I see a flash message indicating that the pet has been added to my favorites list
# The favorite indicator in the nav bar has incremented by one
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

    @pet_1 = @shelter_1.pets.create!(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Bailey",
              age: "3",
              sex: "Female",
              description: "She's a 85 pound lap dog!",
              status: "Adoptable"
              )
  end

  it "I see a button or link to favorite that pet" do

    visit "/pets/#{@pet_1.id}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_link("Add to Favorites")

    click_link("Add to Favorites")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Success, #{@pet_1.name} has been added to your favorites!")

    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end
  end
end
