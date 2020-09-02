require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  before(:each) do
    @shelter_1 = Shelter.create!({
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

  it "When I visit /pets/:id I see all the information about this pet" do

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.status)
  end

  it " When I visit a pets show page, the adoption status name is a link" do

    shelter_1 = Shelter.create!({
            name: "Primary Shelter",
            address: "123 Maple Ave.",
            city: "Denver",
            state: "CO",
            zip: "80438"
            })

    pet_1 = shelter_1.pets.create!(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Bailey",
              age: "3",
              sex: "Female",
              description: "She's a 85 pound lap dog!",
              status: "Pending"
              )

    application_1 = AdoptionApplication.create!(
      name: "Dan",
      address: "123 Pine Ave.",
      city: "Denver",
      state: "CO",
      zip: "80662",
      phone: "8675319",
      description: "I am a fantastic pet owner"
      )

    PetAdoption.create!(pet_id: pet_1.id,
                        adoption_application_id: application_1.id,
                        status: "Pending")

    visit "/pets/#{pet_1.id}"
    expect(page).to have_link("Dan")
    click_link("Dan")
    expect(current_path).to eq("/applications/#{application_1.id}")
  end
end
