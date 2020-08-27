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
          
    @pet_2 = @shelter_1.pets.create(
              image: "https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg",
              name: "Rio",
              age: "13",
              sex: "Male"
              )
  end

  it "When I visit /shelters/:id, there is a link to delete each of the shelters reviews" do

    visit "/pets"

    within "navbar" do
      click_link "| Pet Index |"
    end
    
    expect(current_path).to eq("/pets")
  
  end
end