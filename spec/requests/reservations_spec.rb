require "rails_helper"

RSpec.describe "Reservations endpoint", type: :request do
  describe "POST /reservations" do
    context "When there is a current customer with the same vehicle" do
      let!(:customer) { create(:customer) }
      let!(:vehicle) { create(:vehicle, customer: customer) }
      let!(:service) { create(:service) }

      it "should create a new reservation" do
        request_payload = {
          reservation: {
            vehicle_id: vehicle.id,
            service_id: service.id,
            start_time: Time.now,
            end_time: Time.now+1
          }
        }
        post "/reservations", params: request_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["id"]).to_not be_nil
        expect(response).to have_http_status(:created)
      end

      it "should return a error when the reservation is not valid" do
        request_payload = {
          reservation: {
            customer_id: customer.id,
            service_id: service.id
          }
        }
        post "/reservations", params: request_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["error"]).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should return a error when the timeslot is not valid" do
        create(:reservation,
              service: service,
              vehicle: vehicle,
              start_time: DateTime.new(2021, 11, 5, 12, 0, 0),
              end_time: DateTime.new(2021, 11, 5, 12, 59, 59))
        request_payload = {
          reservation: {
            vehicle_id: vehicle.id,
            service_id: service.id,
            start_time: DateTime.new(2021, 11, 5, 12, 0, 0),
            end_time: DateTime.new(2021, 11, 5, 12, 0, 0)
          }
        }
        post "/reservations", params: request_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["error"]).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "POST /reservations" do
    context "When there is a current customer with a new vehicle" do
      let!(:customer) { create(:customer) }
      let!(:service) { create(:service) }

      it "should create a new reservation" do
        request_payload = {
          reservation: {
            customer_id: customer.id,
            service_id: service.id,
            start_time: Time.now,
            end_time: Time.now+1,
            vehicle_attributes: {
              make: "Mazda",
              model: "CX5",
              year: 2015,
              customer_id: customer.id
            }
          }
        }
        post "/reservations", params: request_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["id"]).to_not be_nil
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "POST /reservations" do
    context "When there is a new customer with a new vehicle" do
      let!(:service) { create(:service) }

      it "should create a new reservation" do
        request_payload = {
          reservation: {
            service_id: service.id,
            start_time: Time.now,
            end_time: Time.now+1,
            vehicle_attributes: {
              make: "Mazda",
              model: "CX5",
              year: 2015,
              customer_attributes: {
                name: "Francisco Guevara",
                email: "fguevara@mail.com"
              }
            }
          }
        }
        post "/reservations", params: request_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["id"]).to_not be_nil
        expect(response).to have_http_status(:created)
      end
    end
  end
end