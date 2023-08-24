require 'rails_helper'

RSpec.describe "V1::SuperAdmin::Restaurants", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/v1/super_admin/restaurants/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/v1/super_admin/restaurants/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/v1/super_admin/restaurants/show"
      expect(response).to have_http_status(:success)
    end
  end

end
