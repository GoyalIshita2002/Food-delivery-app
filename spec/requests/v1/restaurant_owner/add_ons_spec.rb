require 'rails_helper'

RSpec.describe "V1::RestaurantOwner::AddOns", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/v1/restaurant_owner/add_ons/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/v1/restaurant_owner/add_ons/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/v1/restaurant_owner/add_ons/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
