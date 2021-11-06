require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it "validates presence of required fields" do
      should validate_presence_of(:email)
      should validate_presence_of(:name)
    end

    it "validate relationships" do
      should have_many(:vehicles)
    end
  end
end
