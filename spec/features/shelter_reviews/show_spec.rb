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

  it "I all reviews for a shelter on the shelter's show page" do
    @shelter_1.shelter_reviews.create!(title: "A very nice shelter!",
                               rating: "5",
                               content: "I was very pleased with the customer service, it is second to none!",
                               image: "https://www.timesheraldonline.com/wp-content/uploads/2020/04/202020ETS20May20Corona20Press20Graphic.jpg?w=1020"
                              )

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content("Title: #{@shelter_1.shelter_reviews.last.title}")
    expect(page).to have_content("Rating: #{@shelter_1.shelter_reviews.last.rating}")
    expect(page).to have_content("Content: #{@shelter_1.shelter_reviews.last.content}")
    expect(page).to have_css("img[src*='https://www.timesheraldonline.com/wp-content/uploads/2020/04/202020ETS20May20Corona20Press20Graphic.jpg?w=1020']")
    
    # User Story 2, Shelter Reviews
    #
    # As a visitor,
    # When I visit a shelter's show page,
    # I see a list of reviews for that shelter
    # Each review will have:
    # - title
    # - rating
    # - content
    # - an optional picture
  end
end
