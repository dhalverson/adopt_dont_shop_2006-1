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
  end

  it "I can create new shelter reviews" do

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_link("New Review")

    expect(page).to_not have_content("Review string")
    expect(page).to_not have_content("Review rating")
    expect(page).to_not have_content("Review content")

    # expect(@shelter_1.reviews).to eq(nil)

    click_on "New Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

    fill_in 'Title', with: "Review string"
    fill_in 'Rating', with: "Review rating"
    fill_in 'Content', with: "Review content"
    fill_in 'Image', with: "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg"

    click_on "Create Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    
    click_on "Edit Review"
    
    fill_in 'Title', with: "Review string"
    fill_in 'Rating', with: ""
    fill_in 'Content', with: ""
    fill_in 'Image', with: ""
    click_on "Update Review"
    
    expect(page).to have_content("Review not updated, please fill in a title, rating, and/or content")
    
  end
end