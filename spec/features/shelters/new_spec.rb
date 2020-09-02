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

  it "When I visit /shelters, there is a link that takes me to a form to create a new shelter" do

    visit "/shelters"

    expect(page).to have_link("New Shelter")
    expect(page).to_not have_content('The New Shelter')
    expect(Shelter.last.name).to_not eq("The New Shelter")

    click_link 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in 'Name', with: 'The New Shelter'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Conifer'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80423'

    click_on 'Create Shelter'

    expect(current_path).to eq("/shelters")
    expect(Shelter.last.name).to eq("The New Shelter")
    expect(page).to have_content('The New Shelter')
  end

  it "When I update or create a new shelter without all the information, I see a flash message with what fields are missing" do

    visit("/shelters")
    click_link("New Shelter")
    expect(current_path).to eq('/shelters/new')

    fill_in 'Name', with: 'The New Shelter'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'Zip', with: '80423'

    click_button("Create Shelter")
    expect(page).to have_content("Error: Please enter the following information and resubmit: {"city"=>"", "state"=>""}")
    expect(current_path).to eq("/shelters/new")
  end

  it "When I update a new shelter without all the information, I see a flash message with what fields are missing" do

    visit("/shelters/#{@shelter_1.id}")
    click_link("Update Shelter")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in 'Name', with: 'The New Shelter'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'Zip', with: '80423'

    click_button("Update Shelter")
    expect(page).to have_content("Error: Please enter the following information and resubmit: {"city"=>"", "state"=>""}")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
  end
end
