require 'rails_helper'

RSpec.describe "V1::Restaurants", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/v1/restaurants/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/v1/restaurants/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/v1/restaurants/update"
      expect(response).to have_http_status(:success)
    end
  end

end
