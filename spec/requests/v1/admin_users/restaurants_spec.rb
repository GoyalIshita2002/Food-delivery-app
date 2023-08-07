require 'rails_helper'

RSpec.describe "V1::AdminUsers::Restaurants", type: :request do
  describe "GET /details" do
    it "returns http success" do
      get "/v1/admin_users/restaurants/details"
      expect(response).to have_http_status(:success)
    end
  end

end
