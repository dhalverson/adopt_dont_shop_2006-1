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

  it "I can view an application's show page" do

    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.phone)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)

    click_link "#{@pet_2.name}"

    expect(current_path).to eq("/pets/#{@pet_2.id}")

  end

  it "I can approve applications and see the status" do

    visit "/applications/#{@application_1.id}"
    expect(page).to have_link("Approve application for")
    click_link("Approve application for", match: :first)

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("pending application by #{@application_1.name}")
  end

end

# User Story 22, Approving an Application

# User Story 22
# As a visitor
# When I visit an application's show page
# For every pet that the application is for, I see a link to approve the application for that specific pet
# When I click on a link to approve the application for one particular pet
# I'm taken back to that pet's show page
# And I see that the pets status has changed to 'pending'
# And I see text on the page that says who this pet is on hold for (Ex: "On hold for John Smith", given John Smith is the name on the application that was just accepted)




# User Story 19, Application Show Page
#
# As a visitor
# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pet's that this application is for (all names of pets should be links to their show page)
