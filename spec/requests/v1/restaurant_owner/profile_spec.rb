require 'rails_helper'

RSpec.describe "V1::RestaurantOwner::Profiles", type: :request do
  describe "GET /update" do
    it "returns http success" do
      get "/v1/restaurant_owner/profile/update"
      expect(response).to have_http_status(:success)
    end
  end

end
