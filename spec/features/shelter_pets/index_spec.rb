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
            
    @pet_1 = @shelter_1.pets.create(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Bailey",
              age: "3",
              sex: "Female"
              )
              
    @pet_1 = @shelter_1.pets.create(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Rio",
              age: "13",
              sex: "Male"
              )
  end
  
  it "I can see all pets by shelter" do
    visit "/shelters/#{@shelter_1.id}/pets"
  
    expect(page).to have_content("Name: Bailey")
    expect(page).to have_content("Age: 3")
    expect(page).to have_content("Sex: Female")
    
    expect(page).to have_content("Name: Rio")
    expect(page).to have_content("Age: 13")
    expect(page).to have_content("Sex: Male")
  end
  
  it "I have a link to access pets for this shelter" do
    visit "/shelters/#{@shelter_1.id}"
    
    click_link "Shelter's Pets Page"
    
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  
    expect(page).to have_content("Name: Bailey")
    expect(page).to have_content("Age: 3")
    expect(page).to have_content("Sex: Female")
    
    expect(page).to have_content("Name: Rio")
    expect(page).to have_content("Age: 13")
    expect(page).to have_content("Sex: Male")
  end
  
  it "The count of pets for each shelter is indicated on the shelter pets index page" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content("Available Pets Here: #{@shelter_1.pets.count}")
  end
end
