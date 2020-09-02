
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

  it "From my favorites page, I see a button or link to remove that pet from my favorites" do

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end

    click_link("Favorites - 1")
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Remove from Favorites")
    # need to have a within here to specify if multiple?
    click_link("Remove from Favorites")
    expect(page).to have_content("Success, #{@pet_1.name} has been removed from your favorites!")

    expect(current_path).to eq("/favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 0")
    end
  end

  it "From my favorites page, I see a link to remove all favorited pets" do

    pet_2 = @shelter_1.pets.create!(
              image: "https://i.pinimg.com/originals/ea/cd/6a/eacd6a5cbcf58c93fa4cfc4d83159896.jpg",
              name: "Bruiser",
              age: "2",
              sex: "Male",
              description: "He's a 185 pound lap dog!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end

    visit "/pets/#{pet_2.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 2")
    end

    click_link("Favorites - 2")
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Remove All Favorited Pets")
    click_link("Remove All Favorited Pets")

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Success, all pets have been removed from your favorites!")
    within "navbar" do
      expect(page).to have_link("Favorites - 0")
    end
  end
end

