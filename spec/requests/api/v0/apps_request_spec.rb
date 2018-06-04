require "rails_helper"

RSpec.describe "Apps", :type => :request, api: :v0 do

  context "valid admin token" do
    before { set_admin_api_token }

    it "creates an app" do
      api_post 'apps'
      expect(response).to have_http_status(:created)

      bound_response = Api::V0::Bindings::App.new(json_response)

      expect(bound_response.name).to be_blank
      expect(bound_response.id).to be_a String
      expect(bound_response.api_id.length).to be >= 8
      expect(bound_response.api_token.length).to be >= 20
      expect(bound_response.whitelisted_domains).to be_empty
    end

    context "an app is not present" do
      test_request_status(self, :get, "apps/42", :not_found)
      test_request_status(self, :put, "apps/42", :not_found)
      test_request_status(self, :delete, "apps/42", :not_found)
    end

    context "when an app is present" do
      let(:an_app) { App.create }

      it "can be retrieved" do
        api_get "apps/#{an_app.id}"
        expect(response).to have_http_status(:ok)

        expect(json_response[:id]).to eq an_app.id
        expect(json_response[:api_id]).to eq an_app.api_id
        expect(json_response[:api_token]).to eq an_app.api_token
        expect(json_response[:whitelisted_domains]).to eq an_app.whitelisted_domains
      end

      it "can be destroyed" do
        api_delete "apps/#{an_app.id}"
        expect(response).to have_http_status(:ok)
        expect(App.find(an_app.id)).to be_nil
      end

      it "can be updated" do

      end

      context "#update" do
        it "can update just name" do
          api_put "apps/#{an_app.id}", params: app_update_json(name: "Hiya")
          expect(response).to have_http_status(:ok)

          expect_valid_app_response do |bound_response|
            expect(bound_response.name).to eq "Hiya"
          end

          expect(App.find(an_app.id).name).to eq "Hiya"
        end

        it "can update with no updates" do

        end

        it "can update just whitelisted domains" do

        end

        it "can give a single whitelisted domain" do

        end

      end

    end
  end

  def expect_valid_app_response
    bound_response = Api::V0::Bindings::App.new(json_response)
    expect(bound_response).to be_valid
    yield bound_response
  end

  # def bound_app_response
  #   Api::V0::Bindings::App.new(json_response)
  # end

  context "invalid admin token" do
    before { set_bad_admin_api_token }

    test_request_status(self, :post, "apps", :forbidden)
    test_request_status(self, :get, "apps/42", :forbidden)
    test_request_status(self, :get, "apps", :forbidden)
    test_request_status(self, :put, "apps/42", :forbidden)
    test_request_status(self, :delete, "apps/42", :forbidden)
  end

  context "missing admin token" do
    test_request_status(self, :post, "apps", :unauthorized)
    test_request_status(self, :get, "apps/42", :unauthorized)
    test_request_status(self, :get, "apps", :unauthorized)
    test_request_status(self, :put, "apps/42", :unauthorized)
    test_request_status(self, :delete, "apps/42", :unauthorized)
  end


  def app_update_json(hash)
    Api::V0::Bindings::AppUpdate.new.build_from_hash(hash).to_body.to_json
  end


end
