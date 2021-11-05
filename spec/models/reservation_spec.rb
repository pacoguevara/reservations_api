require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do
    it "validates presence of required fields" do
      should validate_presence_of(:customer_id)
      should validate_presence_of(:vehicle_id)
      should validate_presence_of(:service_id)
      should validate_presence_of(:start_time)
      should validate_presence_of(:end_time)
    end

    it "validate relationships" do
      should belong_to(:customer)
    end
  end
end
