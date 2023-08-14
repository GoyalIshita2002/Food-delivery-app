require 'rails_helper'

RSpec.describe "V1::RestaurantOwner::Dishes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/v1/restaurant_owner/dishes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/v1/restaurant_owner/dishes/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/v1/restaurant_owner/dishes/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/v1/restaurant_owner/dishes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
