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
            city: "Casper",
            state: "WY",
            zip: "33221"
            })
  end
  
  it "When I visit /shelters/:id I see all information pertaining to this shelter" do

    visit "/shelters/#{@shelter_1.id}"

    expect(@shelter_1.nil?).to eq(false)
  
    expect(page).to have_link("Delete Shelter")
    
    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")
    
    expect(@shelter_1.nil?).to eq(true)
  end
end