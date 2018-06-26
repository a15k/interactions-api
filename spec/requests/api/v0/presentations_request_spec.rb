require "rails_helper"

RSpec.describe "Presentations", :type => :request, api: :v0 do

  include_examples "v0 API ID checks", route_prefix: "presentations",
                                       actions: [:create]

  let!(:an_app) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  let!(:another_app) do
    App.create.tap do |app|
      app.update(name: "another", whitelisted_domains: "google.com")
    end
  end

  before { set_api_id(an_app.api_id) }
  before { set_origin("https://tutor.openstax.org:80") }
  let(:origin_host) { "tutor.openstax.org" }
  let(:presentation_time) { Time.current.utc }

  context "first presentation" do
    it "succeeds and returns empty data" do
      api_post "presentations", params: presentation_json()

      expect_valid_bound_response(Api::V0::Bindings::PresentationResponse, :created) do |bound_response|
        expect(bound_response.flags).to be_empty
        expect(bound_response.ratings).to be_empty
      end
    end
  end

  context "presentation after flagging" do
    # Mix of flags from this app, another app, target content, other content, target user, other user
    let!(:flag_1) { create_flag(app: an_app, content_uid: "a", user_uid: "1") }
    let!(:flag_2) { create_flag(app: an_app, content_uid: "a", user_uid: "1") }
    let!(:flag_3) { create_flag(app: an_app, content_uid: "b", user_uid: "1") }
    let!(:flag_4) { create_flag(app: an_app, content_uid: "a", user_uid: "2") }
    let!(:flag_4) { create_flag(app: another_app, content_uid: "a", user_uid: "1") }

    it "succeeds and returns related flags" do
      api_post "presentations", params: presentation_json(content_uid: "a", user_uid: "1")

      expect_valid_bound_response(Api::V0::Bindings::PresentationResponse, :created) do |bound_response|
        expect(bound_response.flags.map{|fh| fh[:id]}).to contain_exactly(flag_1.id, flag_2.id)

        first_flag = Api::V0::Bindings::Flag.new(bound_response.flags.select{|fh| fh[:id] == flag_1.id}[0])
        expect(first_flag.content_uid).to eq flag_1.content_uid
        expect(first_flag.user_uid).to eq flag_1.user_uid
      end
    end
  end

  context "presentation after rating" do
    # Mix of ratings from this app, another app, target content, other content, target user, other user
    let!(:rating_1) { create_rating(app: an_app, content_uid: "a", user_uid: "1") }
    let!(:rating_2) { create_rating(app: an_app, content_uid: "a", user_uid: "1") }
    let!(:rating_3) { create_rating(app: an_app, content_uid: "b", user_uid: "1") }
    let!(:rating_4) { create_rating(app: an_app, content_uid: "a", user_uid: "2") }
    let!(:rating_4) { create_rating(app: another_app, content_uid: "a", user_uid: "1") }

    it "succeeds and returns related ratings" do
      api_post "presentations", params: presentation_json(content_uid: "a", user_uid: "1")

      expect_valid_bound_response(Api::V0::Bindings::PresentationResponse, :created) do |bound_response|
        expect(bound_response.ratings.map{|rh| rh[:id]}).to contain_exactly(rating_1.id, rating_2.id)

        first_rating = Api::V0::Bindings::Rating.new(bound_response.ratings.select{|rf| rf[:id] == rating_1.id}[0])
        expect(first_rating.content_uid).to eq rating_1.content_uid
        expect(first_rating.user_uid).to eq rating_1.user_uid
      end
    end
  end

  context "presentation of a variant" do
    let!(:flag_1) { create_flag(app: an_app, content_uid: "a", user_uid: "1", variant_id: "42") }
    let!(:flag_2) { create_flag(app: an_app, content_uid: "a", user_uid: "1", variant_id: "23") }
    let!(:rating_1) { create_rating(app: an_app, content_uid: "a", user_uid: "1", variant_id: "42") }
    let!(:rating_2) { create_rating(app: an_app, content_uid: "a", user_uid: "1", variant_id: "23") }

    it "succeeds and returns related flags" do
      api_post "presentations", params: presentation_json(content_uid: "a", user_uid: "1", variant_id: "42")

      expect_valid_bound_response(Api::V0::Bindings::PresentationResponse, :created) do |bound_response|
        expect(bound_response.flags.map{|fh| fh[:id]}).to contain_exactly(flag_1.id)
        returned_flag = Api::V0::Bindings::Flag.new(bound_response.flags[0])
        expect(returned_flag.variant_id).to eq "42"

        expect(bound_response.ratings.map{|rh| rh[:id]}).to contain_exactly(rating_1.id)
        returned_rating = Api::V0::Bindings::Rating.new(bound_response.ratings[0])
        expect(returned_rating.variant_id).to eq "42"
      end
    end
  end

  def presentation_json(overrides = {})
    hash = {
      content_uid: SecureRandom.uuid,
      variant_id: nil,
      user_uid: SecureRandom.uuid,
      presented_at: presentation_time.utc.iso8601
    }.merge(overrides)

    {presentation: Api::V0::Bindings::Presentation.new.build_from_hash(hash).to_body}.to_json
  end

  def create_flag(app:, content_uid: SecureRandom.uuid, variant_id: nil, user_uid: SecureRandom.uuid)
    Flag.create(app_api_id: app.api_id,
                source_domain: app.whitelisted_domains.first,
                content_uid: content_uid,
                variant_id: variant_id,
                user_uid: user_uid,
                type: "typo",
                explanation: SecureRandom.hex(3))
  end

  def create_rating(app:, content_uid: SecureRandom.uuid, variant_id: nil, user_uid: SecureRandom.uuid)
    Rating.create(app_api_id: app.api_id,
                  source_domain: app.whitelisted_domains.first,
                  content_uid: content_uid,
                  variant_id: variant_id,
                  user_uid: user_uid,
                  type: "thumbs",
                  value: 0.5)
  end

end
