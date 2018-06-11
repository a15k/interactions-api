require 'rails_helper'

RSpec.describe Flag do

  let(:app) { App.create }

  context "#create" do
    context "app exists" do
      it "can be created" do
        flag = create(app_api_id: app.api_id)
        expect(flag.id).to be_a_kind_of(String)
        retrieved_flag = described_class.find(flag.id)
        expect(retrieved_flag.id).to eq flag.id
      end

      it "cannot be created with an invalid type" do
        flag = create(app_api_id: app.api_id, type: "blah")
        expect(flag.errors).not_to be_empty
        expect(flag).not_to be_valid
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

  context "#find_all" do
    it "can return multiple" do
      flag_1 = create(app_api_id: app.api_id)
      flag_2 = create(app_api_id: app.api_id)
      expect(described_class.find_all(flag_1.id, flag_2.id).map(&:id)).to eq [flag_1.id, flag_2.id]
    end

    it "raises an error if can't find all IDs" do
      flag = create(app_api_id: app.api_id)
      expect{described_class.find_all(flag.id, "nope")}.to raise_error(NotAllItemsFound, /nope/)
    end
  end

  context "#update" do
    it "cannot be updated with an invalid type" do
      flag = create(app_api_id: app.api_id, type: "typo")
      expect(flag).to be_valid
      flag.update(type: "blah")
      expect(flag.errors).not_to be_empty
      expect(flag).not_to be_valid
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
