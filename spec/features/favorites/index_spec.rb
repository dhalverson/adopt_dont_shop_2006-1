# User Story 10, Favorite Index Page
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites index page ("/favorites")
# I see all pets I've favorited
# Each pet in my favorites shows the following information:
# - pet's name (link to pets show page)
# - pet's image
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

    @pet_2 = @shelter_1.pets.create!(
              image: "https://i.pinimg.com/originals/ea/cd/6a/eacd6a5cbcf58c93fa4cfc4d83159896.jpg",
              name: "Bruiser",
              age: "2",
              sex: "Male",
              description: "He's a 185 pound lap dog!",
              status: "Adoptable"
              )
  end

  it "I visit my favorites index page I see all pets I've favorited" do

    visit "/pets/#{@pet_1.id}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end

    visit "/pets/#{@pet_2.id}"
    expect(current_path).to eq("/pets/#{@pet_2.id}")
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    within "navbar" do
      expect(page).to have_link("Favorites - 2")
      click_link "Favorites - 2"
    end

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_css("img[src*='#{@pet_1.image}']")
    expect(page).to have_content("#{@pet_2.name}")
    expect(page).to have_css("img[src*='#{@pet_2.image}']")
  end

  it "When I have no favorites, and I visit my favorites page, I see text saying I have no favorited pets" do

    visit "/favorites"
    within "navbar" do
      expect(page).to have_content("Favorites - 0")
    end
    expect(page).to have_content("You have no favorited pets!")
  end

  it "When I visit the favorites index, I see a list of all pets with at least one application on them" do

    visit "/pets/#{@pet_1.id}"
    click_link("Add to Favorites")

    visit "/pets/#{@pet_2.id}"
    click_link("Add to Favorites")

    click_link("Favorites - 2")
    click_link("Adopt My Favorites")

    select("#{@pet_1.name}")
    fill_in 'Name', with: 'John Doe'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Casper'
    fill_in 'State', with: 'WY'
    fill_in 'Zip', with: '33221'
    fill_in 'Phone', with: '8675309'
    fill_in 'Description', with: 'I am an overly qualified pet owner!'

    click_button("Submit Application")
    expect(current_path).to eq("/favorites")
    expect(page).to have_link("#{@pet_1.name}")

    click_link("#{@pet_1.name}")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
