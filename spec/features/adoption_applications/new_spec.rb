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

  it "" do

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
    expect(page).to have_link("Adopt My Favorites")
    click_link("Adopt My Favorites")

    expect(current_path).to eq("/adoption_applications/new")
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
    expect(page).to have_content("Application succesfully submitted for selected pets")

    expect(page).to_not have_content("#{@pet_1.name}")
    expect(page).to_not have_css("img[src*='https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg']")
  end
end




# User Story 16, Applying for a Pet
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
