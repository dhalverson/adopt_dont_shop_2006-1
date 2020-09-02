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
    @shelter_2 = Shelter.create!({
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
      name: "Sue",
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
                        
    @shelter_1.shelter_reviews.create!(title: "Ok",
                                      rating: "3",
                                      content: "I like them")
    @shelter_1.shelter_reviews.create!(title: "Ok",
                                      rating: "1",
                                      content: "I dislike them")
    @shelter_1.shelter_reviews.create!(title: "Ok",
                                      rating: "4",
                                      content: "I love them")
  end
  
  it "When I visit /shelters/:id I see all information pertaining to this shelter" do

    visit "/shelters/#{@shelter_1.id}"
    
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
    
    visit "/shelters/#{@shelter_2.id}"
    
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_2.address)
    expect(page).to have_content(@shelter_2.city)
    expect(page).to have_content(@shelter_2.state)
    expect(page).to have_content(@shelter_2.zip)
  end
  
  it "When I visit /shelters/:id I see some statistics pertaining to this shelter" do
    
  visit "/shelters/#{@shelter_1.id}"
  save_and_open_page
  
  expect(page).to have_content("3")
  expect(page).to have_content("2")
  expect(page).to have_content("2.7")

  end
end