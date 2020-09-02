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

  it "I cannot add a pet more than once to my favorites" do

    visit "/pets/#{@pet_1.id}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_link("Add to Favorites")

    click_link("Add to Favorites")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Success, #{@pet_1.name} has been added to your favorites!")

  end
end