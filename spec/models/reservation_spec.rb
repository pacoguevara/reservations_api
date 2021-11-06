require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do
    it "validates presence of required fields" do
      should validate_presence_of(:service_id)
      should validate_presence_of(:start_time)
      should validate_presence_of(:end_time)
    end

    it "validate relationships" do
      should belong_to(:vehicle)
    end

    it "should return true if a timeslot is valid" do
      customer = create(:customer)
      service = create(:service)
      vehicle = create(:vehicle, customer: customer)
      create(:reservation,
              service: service,
              vehicle: vehicle,
              start_time: DateTime.new(2021, 11, 5, 12, 0, 0),
              end_time: DateTime.new(2021, 11, 5, 12, 59, 59))
      create(:reservation,
              service: service,
              vehicle: vehicle,
              start_time: DateTime.new(2021, 11, 5, 14, 0, 0),
              end_time: DateTime.new(2021, 11, 5, 14, 59, 59))
      reservation = create(:reservation,
                            service: service,
                            vehicle: vehicle,
                            start_time: DateTime.new(2021, 11, 5, 13, 0, 0),
                            end_time: DateTime.new(2021, 11, 5, 13, 59, 59))
      expect(reservation.valid_timeslot?).to eq true
    end

    it "should return false if a timeslot is not valid" do
      customer = create(:customer)
      service = create(:service)
      vehicle = create(:vehicle, customer: customer)
      create(:reservation,
              service: service,
              vehicle: vehicle,
              start_time: DateTime.new(2021, 11, 5, 12, 0, 0),
              end_time: DateTime.new(2021, 11, 5, 12, 59, 59))
      create(:reservation,
              service: service,
              vehicle: vehicle,
              start_time: DateTime.new(2021, 11, 5, 13, 0, 0),
              end_time: DateTime.new(2021, 11, 5, 14, 30, 59))
      reservation = create(:reservation,
                            service: service,
                            vehicle: vehicle,
                            start_time: DateTime.new(2021, 11, 5, 12, 30, 0),
                            end_time: DateTime.new(2021, 11, 5, 13, 59, 59))
      expect(reservation.valid_timeslot?).to eq false
    end
  end
end
