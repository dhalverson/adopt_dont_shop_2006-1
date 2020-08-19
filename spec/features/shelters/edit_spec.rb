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
  
  it "When I visit /shelters/:id, there is a link that takes me to a form to update/edit this shelter's information" do

    visit "/shelters/#{@shelter_1.id}"
    
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
    
    expect(page).to_not have_content("The Updated Shelter")
    expect(page).to_not have_content("12 Main St.")
    expect(page).to_not have_content("Casper")
    expect(page).to_not have_content("WY")
    expect(page).to_not have_content("33221")
    
    expect(page).to have_link("Update Shelter")
    
    click_link "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in 'Name', with: 'The Updated Shelter'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Casper'
    fill_in 'State', with: 'WY'
    fill_in 'Zip', with: '33221'
    
    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    
    expect(page).to have_content("The Updated Shelter")
    expect(page).to have_content("12 Main St.")
    expect(page).to have_content("Casper")
    expect(page).to have_content("WY")
    expect(page).to have_content("33221")

  end
end