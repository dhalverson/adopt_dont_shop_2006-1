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
  
  it "I can edit a shelters' pets" do
    blank_input = " "
    
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_link("Create Pet")
    
    click_on "Create Pet"
    
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    
    fill_in 'Image', with: @pet_1.image
    fill_in 'Name', with: @pet_1.name
    fill_in 'Description', with: @pet_1.description
    fill_in 'Age', with: @pet_1.age
    fill_in 'Sex', with: @pet_1.sex
    
    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  
    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")
  end
end