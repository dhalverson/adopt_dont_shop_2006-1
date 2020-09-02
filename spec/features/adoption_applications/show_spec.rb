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
                        adoption_application_id: @application_2.id,
                        status: "Pending")
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
    expect(page).to have_content("Pending application by #{@application_1.name}")
  end

  it "More than one application cannot be approved for a pet" do

    visit "/pets/#{@pet_2.id}"

    visit "/applications/#{@application_1.id}"
    expect(page).to_not have_link("Revoke application for")
    click_link("Approve application for", match: :first)
    expect(page).to have_content("Adoption Status: Pending")

    visit "/applications/#{@application_1.id}"
    expect(page).to have_link("Revoke application for")

    click_link("Revoke application for", match: :first)
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to_not have_link("Revoke application for")

    visit "/pets/#{@pet_2.id}"
    expect(page).to_not have_content("Adoption Status: Pending")
  end
end

# User Story 25
# As a visitor
# After an application has been approved for a pet
# When I visit that applications show page
# I no longer see a link to approve the application for that pet
# But I see a link to unapprove the application for that pet
# When I click on the link to unapprove the application
# I'm taken back to that applications show page
# And I can see the button to approve the application for that pet again
# When I go to that pets show page
# I can see that the pets adoption status is now back to adoptable
# And that pet is not on hold anymore


# As a visitor
# When a pet has more than one application made for them
# And one application has already been approved for them
# I can not approve any other applications for that pet but all other applications still remain on file (they can be seen on the pets application index page)
# (This can be done by either taking away the option to approve the application, or having a flash message pop up saying that no more applications can be approved for this pet at this time)
