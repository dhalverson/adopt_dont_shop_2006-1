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
    @shelter_2 = Shelter.create({
              name: "Secondary Shelter",
              address: "321 Oak Ave.",
              city: "Denver",
              state: "CO",
              zip: "80438"
              })
  end
  
  it "When I visit /shelters I see the name of each shelter in the system" do

    visit '/shelters'
    
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end
end