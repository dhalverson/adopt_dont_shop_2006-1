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
  
  it "I can delete a shelters' pets" do

    visit "/pets/#{@pet_1.id}"
    
    expect(page).to have_link("Delete Pet")

    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    
    expect(page).to_not have_content("Name: #{@pet_1.name}")
    expect(page).to_not have_content("Age: #{@pet_1.age}")
    expect(page).to_not have_content("Sex: #{@pet_1.sex}")
    expect(page).to_not have_content("Description: #{@pet_1.description}")
    expect(page).to_not have_content("Adoption Status: #{@pet_1.status}")
  end
  
  it "From /pets I can delete a shelters' pets" do

    visit "/pets"
    
    expect(page).to have_link("Delete Pet")

    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")

    click_link("Delete Pet", match: :first)

    expect(current_path).to eq("/pets")
    
    expect(page).to_not have_content("Name: #{@pet_1.name}")
    expect(page).to_not have_content("Age: #{@pet_1.age}")
    expect(page).to_not have_content("Sex: #{@pet_1.sex}")
    expect(page).to_not have_content("Description: #{@pet_1.description}")
    expect(page).to_not have_content("Adoption Status: #{@pet_1.status}")
  end
  
  it "From /pets I can delete a shelters' pets" do

    visit "/shelters/#{@shelter_1.id}/pets"
    
    expect(page).to have_link("Delete Pet")

    expect(page).to have_content("Name: #{@pet_1.name}")
    expect(page).to have_content("Age: #{@pet_1.age}")
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Description: #{@pet_1.description}")
    expect(page).to have_content("Adoption Status: #{@pet_1.status}")

    click_link("Delete Pet", match: :first)

    expect(current_path).to eq("/pets")
    
    expect(page).to_not have_content("Name: #{@pet_1.name}")
    expect(page).to_not have_content("Age: #{@pet_1.age}")
    expect(page).to_not have_content("Sex: #{@pet_1.sex}")
    expect(page).to_not have_content("Description: #{@pet_1.description}")
    expect(page).to_not have_content("Adoption Status: #{@pet_1.status}")
  end
end