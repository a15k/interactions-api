require "rails_helper"

RSpec.describe "Apps", :type => :request, api: :v0 do

  include_examples "v0 admin token checks", route_prefix: "apps", actions: [:crud]

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
      let(:an_app) do
        App.create.tap do |app|
          app.update(name: "orig_name", whitelisted_domains: "openstax.org")
        end
      end

      context "#show" do
        it "can be retrieved" do
          api_get "apps/#{an_app.id}"
          expect(response).to have_http_status(:ok)

          expect(json_response[:id]).to eq an_app.id
          expect(json_response[:api_id]).to eq an_app.api_id
          expect(json_response[:api_token]).to eq an_app.api_token
          expect(json_response[:whitelisted_domains]).to eq an_app.whitelisted_domains
        end
      end

      context "#destroy" do
        it "can be destroyed" do
          api_delete "apps/#{an_app.id}"
          expect(response).to have_http_status(:ok)
          expect(App.find(an_app.id)).to be_nil
        end
      end

      context "#update" do
        it "can update just name" do
          api_put "apps/#{an_app.id}", params: app_update_json(name: "Hiya")

          expect_valid_bound_response(Api::V0::Bindings::App) do |bound_response|
            expect(bound_response.name).to eq "Hiya"
            expect(bound_response.whitelisted_domains).to eq ["openstax.org"]
          end

          expect(App.find(an_app.id).name).to eq "Hiya"
          expect(App.find(an_app.id).whitelisted_domains).to eq ["openstax.org"]
        end

        it "can update just whitelisted domains" do
          api_put "apps/#{an_app.id}", params: app_update_json(whitelisted_domains: ["google.com"])

          expect_valid_bound_response(Api::V0::Bindings::App) do |bound_response|
            expect(bound_response.name).to eq "orig_name"
            expect(bound_response.whitelisted_domains).to eq ["google.com"]
          end

          expect(App.find(an_app.id).name).to eq "orig_name"
          expect(App.find(an_app.id).whitelisted_domains).to eq ["google.com"]
        end

        it "can update name and whitelisted domains" do
          api_put "apps/#{an_app.id}",
                  params: app_update_json(name: "boo", whitelisted_domains: ["google.com"])

          expect_valid_bound_response(Api::V0::Bindings::App) do |bound_response|
            expect(bound_response.name).to eq "boo"
            expect(bound_response.whitelisted_domains).to eq ["google.com"]
          end

          expect(App.find(an_app.id).name).to eq "boo"
          expect(App.find(an_app.id).whitelisted_domains).to eq ["google.com"]

        end

        it "can update with no updates" do
          api_put "apps/#{an_app.id}", params: app_update_json({})

          expect_valid_bound_response(Api::V0::Bindings::App) do |bound_response|
            expect(bound_response.name).to eq "orig_name"
            expect(bound_response.whitelisted_domains).to eq ["openstax.org"]
          end

          expect(App.find(an_app.id).name).to eq "orig_name"
          expect(App.find(an_app.id).whitelisted_domains).to eq ["openstax.org"]
        end

        it "gets a 422 for a single whitelisted domain" do
          api_put "apps/#{an_app.id}", params: {app: {whitelisted_domains: "google.com"}}.to_json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

    end
  end

  def app_update_json(hash)
    {app: Api::V0::Bindings::AppUpdate.new.build_from_hash(hash).to_body}.to_json
  end

end
