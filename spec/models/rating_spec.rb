require 'rails_helper'

RSpec.describe Rating do

  let(:app) { App.create }

  context "#create" do
    context "app exists" do
      it "can be created" do
        rating = create(app_api_id: app.api_id)
        expect(rating.id).to be_a_kind_of(String)
        retrieved_rating = described_class.find(rating.id)
        expect(retrieved_rating.id).to eq rating.id
      end

      it "cannot be created with an invalid type" do
        rating = create(app_api_id: app.api_id, type: "blah")
        expect(rating.errors).not_to be_empty
        expect(rating).not_to be_valid
      end

      it "cannot be created with an invalid value" do
        rating = create(app_api_id: app.api_id, value: 2)
        expect(rating.errors).not_to be_empty
        expect(rating).not_to be_valid
      end
    end

    context "app does not exist" do
      it "fails creation" do
        expect{
          rating = create(app_api_id: "notreal")
        }.to raise_error(AppNotFound)
      end
    end
  end

  context "#find" do
    it "returns nil if id blank" do
      expect(described_class.find("")).to be_nil
    end

    it "returns nil if rating not in redis" do
      expect(described_class.find("notreal")).to be_nil
    end
  end

  context "#find_all" do
    it "can return multiple" do
      rating_1 = create(app_api_id: app.api_id)
      rating_2 = create(app_api_id: app.api_id)
      expect(described_class.find_all(rating_1.id, rating_2.id).map(&:id)).to eq [rating_1.id, rating_2.id]
    end

    it "raises an error if can't find all IDs" do
      rating = create(app_api_id: app.api_id)
      expect{described_class.find_all(rating.id, "nope")}.to raise_error(NotAllItemsFound, /nope/)
    end
  end

  def create(app_api_id:,
             source_domain: "google.com",
             content_uid: SecureRandom.uuid,
             variant_id: nil,
             user_uid: SecureRandom.uuid,
             type: "thumbs",
             value: 1.0)
    described_class.create(app_api_id: app_api_id,
                           source_domain: source_domain,
                           content_uid: content_uid,
                           variant_id: variant_id,
                           user_uid: user_uid,
                           type: type,
                           value: value)
  end

end
