require "rails_helper"

RSpec.describe "Apps", :type => :request, api: :v0 do

  context "valid admin token" do
    before { set_admin_api_token }

    it "creates an app" do
      api_post 'apps', headers: headers
      expect(response).to have_http_status(:created)

      bound_response = Api::V0::Bindings::App.new(json_response)

      expect(bound_response.name).to be_blank
      expect(bound_response.id).to be_a String
      expect(bound_response.api_id.length).to be >= 8
      expect(bound_response.api_token.length).to be >= 20
      expect(bound_response.whitelisted_domains).to be_empty
    end

    context "an app is not present" do
      it "gives a 404 for retrieval" do
        api_get 'apps/42', headers: headers
      end

      it "gives a 404 for update" do
        api_put 'apps/42', headers: headers
      end

      it "gives a 404 for delete" do
        api_delete 'apps/42', headers: headers
      end
    end

    context "when an app is present" do
      it "can be retrieved" do

      end

      it "can be destroyed" do

      end

      # update

    end
  end


  context "invalid admin token" do
    before { set_bad_admin_api_token }

    it "cannot create an app" do
      api_post 'apps', headers: headers
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot return an app" do
      api_get 'apps/42', headers: headers
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot list apps" do
      api_get 'apps', headers: headers
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot update an app" do
      api_put 'apps/42', headers: headers
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot destroy an app" do
      api_delete 'apps/42', headers: headers
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "missing admin token" do
    it "cannot create an app" do
      api_post 'apps', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "cannot create an app" do
      api_post 'apps', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "cannot return an app" do
      api_get 'apps/42', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "cannot list apps" do
      api_get 'apps', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "cannot update an app" do
      api_put 'apps/42', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "cannot destroy an app" do
      api_delete 'apps/42', headers: headers
      expect(response).to have_http_status(:unauthorized)
    end
  end


end
