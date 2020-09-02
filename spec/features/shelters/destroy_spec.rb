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
    @shelter_2 = Shelter.create({
            name: "Secondary Shelter",
            address: "321 Oak Ave.",
            city: "Casper",
            state: "WY",
            zip: "33221"
            })

    @pet_1 = @shelter_1.pets.create!(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Bailey",
              age: "3",
              sex: "Female",
              description: "She's a 85 pound lap dog!",
              status: "Adoptable"
              )

    @application_1 = AdoptionApplication.create!(
      name: "Bob",
      address: "123 Maple Ave.",
      city: "Denver",
      state: "CO",
      zip: "80438",
      phone: "8675309",
      description: "I am a semi-good pet owner"
      )

    PetAdoption.create!(pet_id: @pet_1.id,
                        adoption_application_id: @application_1.id,
                        status: "Pending")
  end

  it "When I visit /shelters/:id I can click a link to delete a shelter" do

    visit "/shelters/#{@shelter_1.id}"

    expect(Shelter.first.name).to eq("Primary Shelter")

    expect(page).to have_link("Delete Shelter")

    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")

    expect(Shelter.first.name).to eq("Secondary Shelter")
  end

  it "When I visit /shelters I can click a link to delete a shelter" do

    visit "/shelters"

    expect(Shelter.first.name).to eq("Primary Shelter")

    expect(page).to have_link("Delete Shelter")

    click_link("Delete Shelter", match: :first)

    expect(current_path).to eq("/shelters")

    expect(Shelter.first.name).to eq("Secondary Shelter")
  end

  it "A shelter with pending pets cannot be deleted" do

    visit("/shelters/#{@shelter_1.id}")
    click_link("Delete Shelter")
    expect(page).to have_content("Shelter cannot be deleted due to pending applications")
  end
end
