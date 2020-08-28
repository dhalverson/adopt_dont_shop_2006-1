# User Story 5, Edit a Shelter Review
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
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
    @review_1 = @shelter_1.shelter_reviews.create!(title: "Test title", rating: "5", content: "Test content", image: "https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_960_720.jpg")
  end

  it "When I visit /shelters/:id, there is a link to edit each of the shelters reviews" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link("Edit Review")

    click_on("Edit Review")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")
    expect(find_field('Title').value).to eq(@review_1.title)
    expect(find_field('Rating').value).to eq(@review_1.rating)
    expect(find_field('Content').value).to eq(@review_1.content)
    expect(find_field('Image').value).to eq(@review_1.image)

    fill_in 'Title', with: "Updated title"
    fill_in 'Rating', with: "Updated rating"
    fill_in 'Content', with: "Updated content"
    fill_in 'Image', with: "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg"

    click_on("Update Review")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content("Updated title")
    expect(page).to have_content("Updated rating")
    expect(page).to have_content("Updated content")
    expect(page).to have_css("img[src*='https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg']")

  end
end
