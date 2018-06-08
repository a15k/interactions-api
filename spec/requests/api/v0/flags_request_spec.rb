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

  context "#update" do
    let(:flag) { create_flag }

    it "can update just type" do
      api_put "flags/#{flag.id}", params: flag_update_json(type: "incorrect")

      expect_valid_bound_response(Api::V0::Bindings::Flag) do |bound_response|
        expect(bound_response.type).to eq "incorrect"
        expect(bound_response.explanation).to eq "crazy!"
      end

      expect(Flag.find(flag.id).type).to eq "incorrect"
      expect(Flag.find(flag.id).explanation).to eq "crazy!"
    end

    it "can update just explanation" do
      api_put "flags/#{flag.id}", params: flag_update_json(explanation: "new thing")

      expect_valid_bound_response(Api::V0::Bindings::Flag) do |bound_response|
        expect(bound_response.type).to eq "typo"
        expect(bound_response.explanation).to eq "new thing"
      end

      expect(Flag.find(flag.id).type).to eq "typo"
      expect(Flag.find(flag.id).explanation).to eq "new thing"
    end

    it "can update type and explanation" do
      api_put "flags/#{flag.id}", params: flag_update_json(type: "incorrect", explanation: "something new")

      expect_valid_bound_response(Api::V0::Bindings::Flag) do |bound_response|
        expect(bound_response.type).to eq "incorrect"
        expect(bound_response.explanation).to eq "something new"
      end

      expect(Flag.find(flag.id).type).to eq "incorrect"
      expect(Flag.find(flag.id).explanation).to eq "something new"
    end

    it "can update with no updates" do
      api_put "flags/#{flag.id}", params: flag_update_json({})

      expect_valid_bound_response(Api::V0::Bindings::Flag) do |bound_response|
        expect(bound_response.type).to eq "typo"
        expect(bound_response.explanation).to eq "crazy!"
      end

      expect(Flag.find(flag.id).type).to eq "typo"
      expect(Flag.find(flag.id).explanation).to eq "crazy!"
    end

    it "gets an error for a bad type" do
      api_put "flags/#{flag.id}", params: {flag: {type: "nope"}}.to_json
      expect(response).to have_http_status(:unprocessable_entity)
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

    {flag: Api::V0::Bindings::FlagNew.new.build_from_hash(hash).to_body}.to_json
  end

  def flag_update_json(hash)
    {flag: Api::V0::Bindings::FlagUpdate.new.build_from_hash(hash).to_body}.to_json
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
