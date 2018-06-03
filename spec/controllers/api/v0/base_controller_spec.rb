require 'rails_helper'

RSpec.describe Api::V0::BaseController, type: :controller, api: :v0 do

  controller do
    before_action :clear_app_cache

    before_action :authenticate_admin_api_token, only: :test_authenticate_admin_api_token
    def test_authenticate_admin_api_token; head :ok; end

    before_action :authenticate_api_token, only: :test_authenticate_api_token
    def test_authenticate_api_token; head :ok; end

    before_action :authenticate_api_id_and_domain, only: :test_authenticate_api_id_and_domain
    def test_authenticate_api_id_and_domain; head :ok; end

    def clear_app_cache
      apps.needs_refresh!
    end
  end

  let(:an_app) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  context "#authenticate_admin_api_token" do
    before { routes.draw { get "test_authenticate_admin_api_token" =>
                               "api/v0/base#test_authenticate_admin_api_token" } }

    it "gives unauthorized for missing token" do
      get :test_authenticate_admin_api_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "gives forbidden for bad token" do
      set_bad_admin_api_token
      get :test_authenticate_admin_api_token
      expect(response).to have_http_status(:forbidden)
    end

    it "gives success for good token" do
      set_api_token(Rails.application.secrets.admin_api_token)
      get :test_authenticate_admin_api_token
      expect(response).to have_http_status(:ok)
    end
  end

  context "#authenticate_api_token" do
    before { routes.draw { get "test_authenticate_api_token" =>
                               "api/v0/base#test_authenticate_api_token" } }

    it "gives unauthorized for missing token" do
      get :test_authenticate_api_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "gives forbidden for bad token" do
      set_api_token("notreal")
      get :test_authenticate_api_token
      expect(response).to have_http_status(:forbidden)
    end

    it "gives success for good token" do
      set_api_token(an_app.api_token)
      get :test_authenticate_api_token
      expect(response).to have_http_status(:ok)
    end
  end

  context "#authenticate_api_id_and_domain" do
    before { routes.draw { get "test_authenticate_api_id_and_domain" =>
                               "api/v0/base#test_authenticate_api_id_and_domain" } }

    it "gives unauthorized for missing id" do
      get :test_authenticate_api_id_and_domain
      expect(response).to have_http_status(:unauthorized)
    end

    it "gives forbidden for bad id and bad domain" do
      set_api_id("notreal")
      set_origin("http://www.google.com")
      get :test_authenticate_api_id_and_domain
      expect(response).to have_http_status(:forbidden)
    end

    it "gives forbidden for good id and bad domain" do
      set_api_id(an_app.api_id)
      set_origin("http://www.google.com")
      get :test_authenticate_api_id_and_domain
      expect(response).to have_http_status(:forbidden)
    end

    it "gives forbidden for bad id and good domain" do
      set_api_id("notreal")
      set_origin("http://openstax.org")
      get :test_authenticate_api_id_and_domain
      expect(response).to have_http_status(:forbidden)
    end

    it "gives success for good id and good domain combo" do
      set_api_id(an_app.api_id)
      set_origin("http://tutor.openstax.org")
      get :test_authenticate_api_id_and_domain
      expect(response).to have_http_status(:ok)
    end
  end

  it "correctly reads a bunch of API IDs" do
    expect_api_id_read_correctly("foo")
    expect_api_id_read_correctly("lH4WXfP+Vbqv")
    expect_api_id_read_correctly("uqtRBz8wGkM=")
    expect_api_id_read_correctly("uqtRBz8wGkM=", " \t ")
  end

  it "correctly reads a bunch of API Tokens" do
    expect_api_token_read_correctly("foo")
    expect_api_token_read_correctly("lH4WXfP+Vbqv")
    expect_api_token_read_correctly("uqtRBz8wGkM=")
    expect_api_token_read_correctly("uqtRBz8wGkM=", "\t ")
  end

  def expect_api_id_read_correctly(id, whitespace=" ")
    expect(api_id(id, whitespace)).to eq id
  end

  def expect_api_token_read_correctly(token, whitespace=" ")
    expect(api_token(token, whitespace)).to eq token
  end

  def api_id(id, whitespace)
    ctrl = Api::V0::BaseController.new
    allow(ctrl).to receive(:request) {
      OpenStruct.new(headers: {'Authorization' => "ID#{whitespace}#{id}"})
    }
    ctrl.send(:api_id)
  end

  def api_token(token, whitespace)
    ctrl = Api::V0::BaseController.new
    allow(ctrl).to receive(:request) {
      OpenStruct.new(headers: {'Authorization' => "Token#{whitespace}#{token}"})
    }
    ctrl.send(:api_token)
  end


end
