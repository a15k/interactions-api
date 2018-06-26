require "rails_helper"

RSpec.describe "Ratings", :type => :request, api: :v0 do

  include_examples "v0 API ID checks", route_prefix: "ratings",
                                       actions: [:create, :show, :destroy]

  let(:an_app) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  before { set_api_id(an_app.api_id) }
  before { set_origin("https://tutor.openstax.org:80") }
  let(:origin_host) { "tutor.openstax.org" }

  context "#create" do
    it "records the rating" do
      api_post "ratings", params: rating_new_json(content_uid: "foo", user_uid: "bar")

      expect(response).to have_http_status(:created)

      bound_response = Api::V0::Bindings::Rating.new(json_response)
      expect(bound_response.content_uid).to eq "foo"
      expect(bound_response.user_uid).to eq "bar"

      created_rating = Rating.find(bound_response.id)

      expect(created_rating.source_domain).to eq "tutor.openstax.org"
      expect(created_rating.app_id).to eq an_app.id
    end
  end

  context "#show" do
    it "retrieves a rating" do
      rating = create_rating

      api_get "ratings/#{rating.id}"

      expect(response).to have_http_status(:ok)

      bound_response = Api::V0::Bindings::Rating.new(json_response)
      expect(bound_response.content_uid).to eq "foo"
      expect(bound_response.variant_id).to eq "yo"
      expect(bound_response.user_uid).to eq "bar"
      expect(bound_response.type).to eq "thumbs"
      expect(bound_response.value).to eq 1.0
    end
  end

  context "#destroy" do
    it "can delete a rating" do
      rating = create_rating

      api_delete "ratings/#{rating.id}"

      expect(response).to have_http_status(:ok)

      bound_response = Api::V0::Bindings::Rating.new(json_response)
      expect(Rating.find(bound_response.id)).to be_nil
    end
  end

  def rating_new_json(overrides = {})
    hash = {
      content_uid: SecureRandom.uuid,
      variant_id: nil,
      user_uid: SecureRandom.uuid,
      type: "thumbs",
      value: 1.0,
    }.merge(overrides)

    {rating: Api::V0::Bindings::RatingNew.new.build_from_hash(hash).to_body}.to_json
  end

  def create_rating
    Rating.create(app_api_id: an_app.api_id,
                  source_domain: origin_host,
                  content_uid: "foo",
                  variant_id: "yo",
                  user_uid: "bar",
                  type: "thumbs",
                  value: 1.0)
  end

end
