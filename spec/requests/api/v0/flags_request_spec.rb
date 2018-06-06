require "rails_helper"

RSpec.describe "Flags", :type => :request, api: :v0 do

  include_examples "v0 API ID checks", route_prefix: "flags",
                                       actions: [:create, :show, :update, :destroy]

  let(:an_app) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  before { set_api_id(an_app.api_id) }
  before { set_origin("https://tutor.openstax.org:80") }
  let(:origin_host) { "tutor.openstax.org" }

  context "#create" do
    it "records the flag" do
      api_post "flags", params: flag_new_json(content_uid: "foo", user_uid: "bar")

      expect(response).to have_http_status(:created)

      bound_response = Api::V0::Bindings::Flag.new(json_response)
      expect(bound_response.content_uid).to eq "foo"
      expect(bound_response.user_uid).to eq "bar"

      created_flag = Flag.find(bound_response.id)

      expect(created_flag.source_domain).to eq "tutor.openstax.org"
      expect(created_flag.app_id).to eq an_app.id
    end
  end

  context "#show" do
    it "retrieves a flag" do
      flag = create_flag

      api_get "flags/#{flag.id}"

      expect(response).to have_http_status(:ok)

      bound_response = Api::V0::Bindings::Flag.new(json_response)
      expect(bound_response.content_uid).to eq "foo"
      expect(bound_response.variant_id).to eq "yo"
      expect(bound_response.user_uid).to eq "bar"
      expect(bound_response.type).to eq "typo"
      expect(bound_response.explanation).to eq "crazy!"
    end
  end

  context "#destroy" do
    it "can delete a flag" do
      flag = create_flag

      api_delete "flags/#{flag.id}"

      expect(response).to have_http_status(:ok)

      bound_response = Api::V0::Bindings::Flag.new(json_response)
      expect(Flag.find(bound_response.id)).to be_nil
    end
  end

  def flag_new_json(overrides = {})
    hash = {
      content_uid: SecureRandom.uuid,
      variant_id: nil,
      user_uid: SecureRandom.uuid,
      type: "typo",
      explanation: "missing period in sentence 4"
    }.merge(overrides)

    Api::V0::Bindings::FlagNew.new.build_from_hash(hash).to_body.to_json
  end

  def create_flag
    Flag.create(app_api_id: an_app.api_id,
                source_domain: origin_host,
                content_uid: "foo",
                variant_id: "yo",
                user_uid: "bar",
                type: "typo",
                explanation: "crazy!")
  end

end
