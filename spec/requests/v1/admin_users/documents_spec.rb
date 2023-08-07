require 'rails_helper'

RSpec.describe "V1::AdminUsers::Documents", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/v1/admin_users/documents/create"
      expect(response).to have_http_status(:success)
    end
  end

end
