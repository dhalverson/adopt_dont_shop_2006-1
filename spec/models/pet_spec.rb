require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
  end
  
  describe "relationships" do
    it {should belong_to :shelter}
  end
  
  it "returns a status" do
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
  expected = Pet.last
  expect(Pet.sort_by_status).to eq(Pet.sort_by_status)
  expect(@pet_1.set_defaults).to eq("Adoptable")
  end
end