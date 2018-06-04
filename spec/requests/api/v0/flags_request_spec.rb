require "rails_helper"

RSpec.describe "Flags", :type => :request, api: :v0 do

  context "create" do
    it "gives forbidden for a bad API ID" do
      set_bad_api_id
      api_post 'flags'
      expect(response).to have_http_status(:forbidden)
    end

    it "gives unauthorized for a missing API ID" do
      # do not set any api ID
      api_post 'flags'
      expect(response).to have_http_status(:unauthorized)
    end

    context "valid API ID" do
      let(:an_app) do
        App.create.tap do |app|
          app.update(name: "whatever", whitelisted_domains: "openstax.org")
        end
      end

      before { set_api_id(an_app.api_id) }

      context "valid domain" do
        before { set_origin("https://tutor.openstax.org:80") }

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

      context "invalid domain" do

      end
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

end
