require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    xit { should validate_presence_of :name }
  end
  
  describe "relationships" do
    it {should belong_to :shelter}
  end
end