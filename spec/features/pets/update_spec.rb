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
  
  it "I can update pet information for a shelter" do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Update Pet")
    
    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")
    
    click_on "Update Pet"
    
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    
    fill_in 'Image', with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=980:*"
    fill_in 'Name', with: "Marco"
    fill_in 'Description', with: "Pet with updated information"
    fill_in 'Age', with: "2"
    fill_in 'Sex', with: "Male"
    
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  
    expect(page).to have_content("Name: Marco")
    expect(page).to have_content("Age: 2")
    expect(page).to have_content("Sex: Male")
    expect(page).to have_content("Description: Pet with updated information")
  end
  
  it "From /pets I can update pet information for a shelter" do
    visit "/pets"
    
    expect(page).to have_link("Update Pet")
    save_and_open_page
    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")
    
    click_on "Update Pet"
    
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    
    fill_in 'Image', with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=980:*"
    fill_in 'Name', with: "Marco"
    fill_in 'Description', with: "Pet with updated information"
    fill_in 'Age', with: "2"
    fill_in 'Sex', with: "Male"
    
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  
    expect(page).to have_content("Name: Marco")
    expect(page).to have_content("Age: 2")
    expect(page).to have_content("Sex: Male")
    expect(page).to have_content("Description: Pet with updated information")
  end
  
  it "From /shelters/shelter_id/pets I can update pet information for a shelter" do
    visit "/shelters/#{@shelter_1.id}/pets"
    
    expect(page).to have_link("Update Pet")

    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")
    
    click_on "Update Pet"
    
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    
    fill_in 'Image', with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=980:*"
    fill_in 'Name', with: "Marco"
    fill_in 'Description', with: "Pet with updated information"
    fill_in 'Age', with: "2"
    fill_in 'Sex', with: "Male"
    
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  
    expect(page).to have_content("Name: Marco")
    expect(page).to have_content("Age: 2")
    expect(page).to have_content("Sex: Male")
    expect(page).to have_content("Description: Pet with updated information")
  end
end