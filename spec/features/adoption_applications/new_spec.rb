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

  it "I can submit an application to adopt pet(s) and they are stored to the database" do

    pet_2 = @shelter_1.pets.create!(
              image: "https://i.pinimg.com/originals/ea/cd/6a/eacd6a5cbcf58c93fa4cfc4d83159896.jpg",
              name: "Bruiser",
              age: "2",
              sex: "Male",
              description: "He's a 185 pound lap dog!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end

    visit "/pets/#{pet_2.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 2")
    end

    click_link("Favorites - 2")
    expect(current_path).to eq("/favorites")
    expect(page).to have_link("Adopt My Favorites")
    click_link("Adopt My Favorites")

    expect(current_path).to eq("/adoption_applications/new")
    select("#{@pet_1.name}")
    fill_in 'Name', with: 'John Doe'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Casper'
    fill_in 'State', with: 'WY'
    fill_in 'Zip', with: '33221'
    fill_in 'Phone', with: '8675309'
    fill_in 'Description', with: 'I am an overly qualified pet owner!'

    click_button("Submit Application")
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Application succesfully submitted for selected pets")
    within ".Favorites" do
      expect(page).to_not have_content("#{@pet_1.name}")
      expect(page).to_not have_css("img[src*='https://allaboutshepherds.com/wp-content/uploads/2016/05/gsd-canoe.jpg']")
    end
  end

  it "I fail to fill out all the information, I'm redirected back to the application form and see a flash message" do

    pet_2 = @shelter_1.pets.create!(
              image: "https://i.pinimg.com/originals/ea/cd/6a/eacd6a5cbcf58c93fa4cfc4d83159896.jpg",
              name: "Bruiser",
              age: "2",
              sex: "Male",
              description: "He's a 185 pound lap dog!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 1")
    end

    visit "/pets/#{pet_2.id}"
    expect(page).to have_link("Add to Favorites")
    click_link("Add to Favorites")
    within "navbar" do
      expect(page).to have_link("Favorites - 2")
    end

    click_link("Favorites - 2")
    expect(current_path).to eq("/favorites")
    expect(page).to have_link("Adopt My Favorites")
    click_link("Adopt My Favorites")

    expect(current_path).to eq("/adoption_applications/new")
    select("#{@pet_1.name}")
    fill_in 'Name', with: 'John Doe'
    fill_in 'Address', with: '12 Main St.'
    fill_in 'City', with: 'Casper'
    fill_in 'State', with: 'WY'
    fill_in 'Zip', with: '33221'
    fill_in 'Phone', with: '8675309'

    click_button("Submit Application")
    expect(current_path).to eq("/adoption_applications/new")
    expect(page).to have_content("Please complete all the fields to submit the application")
  end
end
