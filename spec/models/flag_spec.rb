require 'rails_helper'

RSpec.describe Flag do

  context "#create" do
    context "app exists" do
      let(:app) { App.create }

      it "can be created" do
        flag = create(app_api_id: app.api_id)
        expect(flag.id).to be_a_kind_of(String)
        retrieved_flag = described_class.find(flag.id)
        expect(retrieved_flag.id).to eq flag.id
      end
    end

    context "app does not exist" do
      it "fails creation" do
        expect{
          flag = create(app_api_id: "notreal")
        }.to raise_error(AppNotFound)
      end
    end
  end

  context "#find" do
    it "returns nil if id blank" do
      expect(described_class.find("")).to be_nil
    end

    it "returns nil if flag not in redis" do
      expect(described_class.find("notreal")).to be_nil
    end
  end

  def create(app_api_id:,
             source_domain: "google.com",
             content_uid: SecureRandom.uuid,
             variant_id: nil,
             user_uid: SecureRandom.uuid,
             type: "typo",
             explanation: nil)
    described_class.create(app_api_id: app_api_id,
                           source_domain: source_domain,
                           content_uid: content_uid,
                           variant_id: variant_id,
                           user_uid: user_uid,
                           type: type,
                           explanation: explanation)
  end

end
