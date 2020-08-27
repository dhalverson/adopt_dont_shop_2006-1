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

    @review_1 = @shelter_1.shelter_reviews.create!(title: "Test1 title", rating: "5", content: "Test1 content", image: "https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_960_720.jpg")
    @review_2 = @shelter_1.shelter_reviews.create!(title: "Test2 title", rating: "3", content: "Test2 content")
    @review_3 = @shelter_1.shelter_reviews.create!(title: "Test3 title", rating: "1", content: "Test3 content", image: "https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_960_720.jpg")
  end

  it "When I visit /shelters/:id, there is a link to delete each of the shelters reviews" do

    visit "/shelters/#{@shelter_1.id}"
    
    expect(page).to have_link("Delete Review")
    expect(page).to have_content(@review_1.title)
    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_3.title)
    expect(page).to have_content(@review_1.rating)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_3.rating)
    expect(page).to have_content(@review_1.content)
    expect(page).to have_content(@review_2.content)
    expect(page).to have_content(@review_3.content)
    # expect(page).to have_content(@review_1.image)
    # expect(page).to_not have_content(@review_2.image)
    # expect(page).to have_content(@review_3.image)

    click_link("Delete Review", match: :first)
    
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    
    expect(page).to have_link("Delete Review")
    expect(page).to_not have_content(@review_1.title)
    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_3.title)
    expect(page).to_not have_content(@review_1.rating)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_3.rating)
    expect(page).to_not have_content(@review_1.content)
    expect(page).to have_content(@review_2.content)
    expect(page).to have_content(@review_3.content)
    # expect(page).to_not have_content(@review_1.image)
    # expect(page).to_not have_content(@review_2.image)
    # expect(page).to have_content(@review_3.image)

  end
end