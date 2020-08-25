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

    expect(page).to have_content("Review string")
    expect(page).to have_content("Review rating")
    expect(page).to have_content("Review content")
    # expect(page).to have_content("image placeholder")
  end
end
    # User Story 3, Shelter Review Creation
    #
    # As a visitor,
    # When I visit a shelter's show page
    # I see a link to add a new review for this shelter.
    # When I click on this link, I am taken to a new review path
    # On this new page, I see a form where I must enter:
    # - title
    # - rating
    # - content
    # I also see a field where I can enter an optional image (web address)
    # When the form is submitted, I should return to that shelter's show page
    # and I can see my new review
