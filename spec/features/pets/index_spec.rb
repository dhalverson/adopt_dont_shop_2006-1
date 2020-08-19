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
            
    @pet_1 = Pet.create(
              image: "/app/assets/images/dog_placeholder.png",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter_1
              )
  end
  
  it "When I visit /pets I see the name of each pet in the system along with all information" do

    visit '/pets'
    
    expect(page).to have_css("img[src*='#{@pet_1.image}']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@shelter_1.name)
  end
end
