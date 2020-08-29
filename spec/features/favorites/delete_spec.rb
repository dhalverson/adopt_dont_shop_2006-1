
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

  it "I see a button or link to un-favorite that pet" do

    visit "/pets/#{@pet_1.id}"
    
    within "navbar" do
      expect(page).to have_link("Favorites - 0")
    end
    
    expect(page).to have_content("Add to Favorites")

    click_link "Add to Favorites"
    
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    
    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end
    
    expect(page).to_not have_link("Add to Favorites")
    expect(page).to have_link("Remove from Favorites")
  
    click_link 'Remove from Favorites'
    
    within("navbar") do
      expect(page).to have_link("Favorites - 0")
    end
    
    
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Success, #{@pet_1.name} has been removed from your favorites!")
  end
end



# User Story 12, Can't Favorite a Pet More Than Once
#
# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1