require "rails_helper"

RSpec.describe "Customers endpoint", type: :request do
  describe "GET /customers" do
    
    it "should return OK" do
      get "/customers"
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end

    describe "with data in the DB" do
      let!(:customers) { create_list(:customer, 5) }
      
      it "should return all the customers" do
        get "/customers"
        payload = JSON.parse(response.body)
        expect(payload.size).to eq customers.size
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /customers/:id" do
      let!(:customer) { create(:customer) }
      it "should return a customer" do
        get "/customers/#{customer.id}"
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload["id"]).to eq customer.id
        expect(response).to have_http_status(200)
      end
    end

    describe "Search customer by email" do
      let!(:my_customer) { create(:customer, email: "fguevara@mail.com")}
      it "should return customer filtered by email" do
        create_list(:customer, 3)
        get "/customers?email=#{my_customer.email}"
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq 1
        expect(payload.first["email"]).to eq my_customer.email
        expect(response).to have_http_status(200)
      end
    end
  end
end