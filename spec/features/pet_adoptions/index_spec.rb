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
    @application_1 = AdoptionApplication.create!(
      name: "Bob",
      address: "123 Maple Ave.",
      city: "Denver",
      state: "CO",
      zip: "80438",
      phone: "8675309",
      description: "I am a semi-good pet owner"
      )
    @application_2 = AdoptionApplication.create!(
      name: "Primary Shelter",
      address: "123 Pine Ave.",
      city: "Denver",
      state: "CO",
      zip: "80662",
      phone: "8675319",
      description: "I am a fantastic pet owner"
      )
    PetAdoption.create!(pet_id: @pet_1.id,
                        adoption_application_id: @application_1.id)
    PetAdoption.create!(pet_id: @pet_2.id,
                        adoption_application_id: @application_1.id)
    PetAdoption.create!(pet_id: @pet_2.id,
                        adoption_application_id: @application_2.id)
  end

  it "I can access submitted applications for a pet from that pet's show page" do

    visit "/pets/#{@pet_1.id}"
    
    expect(page).to have_link(@pet_1.adoption_applications.first.name)
    click_link "#{@pet_1.adoption_applications.first.name}"
    
    expect(current_path).to eq("/applications/#{@pet_1.adoption_applications.first.id}")
    
  end
end



# User Story 20, Pet Applications Index Page
#
# As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page %>







