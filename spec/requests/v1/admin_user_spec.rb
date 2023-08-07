require 'rails_helper'

RSpec.describe "V1::AdminUsers", type: :request do
  describe "GET /check_account_availability" do
    it "returns http success" do
      get "/v1/admin_user/check_account_availability"
      expect(response).to have_http_status(:success)
    end
  end

end
