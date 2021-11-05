require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe "validations" do
    it "validates presence of required fields" do
      should validate_presence_of(:make)
      should validate_presence_of(:model)
      should validate_presence_of(:year)
      should validate_presence_of(:customer_id)
    end
  end
end
