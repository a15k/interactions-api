require "rails_helper"

RSpec.describe "Flags", :type => :request, accept: :v0 do

  context "create" do
    context "valid api ID and domain" do

    end

    context "valid api ID but not domain" do

    end

    context "invalid api ID and domain" do

    end

  end


  context "valid api ID and domain" do

  end

  context "valid admin token" do
    before { set_admin_api_token }

    it "creates an app" do
      post '/api/apps', headers: headers
      expect(response).to have_http_status(:created)

      bound_response = Api::V0::Bindings::App.new(json_response)

      expect(bound_response.name).to be_blank
      expect(bound_response.id).to be_a String
      expect(bound_response.api_id.length).to be >= 8
      expect(bound_response.api_token.length).to be >= 20
      expect(bound_response.whitelisted_domains).to be_empty
    end
  end

  context "invalid admin token" do
    before { set_bad_admin_api_token }

    it "cannot create an app" do
      post '/api/apps', headers: headers
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "missing admin token" do
    it "cannot create an app" do
      post '/api/apps', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
