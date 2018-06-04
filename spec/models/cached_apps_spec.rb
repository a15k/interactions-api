require 'rails_helper'

RSpec.describe CachedApps do

  let(:new_instance) { described_class.new }

  context "#does_api_token_exist?" do
    it "returns true if it does exist" do
      create_app("test_1")
      expect(new_instance.does_api_token_exist?("test_1_api_token")).to eq true
    end

    it "returns false is it doesn't exist" do
      expect(new_instance.does_api_token_exist?("unknown_token")).to eq false
    end

    it "returns false if exists but was added recently" do
      cached_apps = new_instance
      create_app("test_1")
      expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq false
    end

    it "returns true if does not exist but was removed recently" do
      app = create_app("test_1")
      cached_apps = new_instance
      app.destroy
      expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq true
    end

    it "returns true if exists and was added more than 30 seconds ago" do
      cached_apps = new_instance
      create_app("test_1")
      Timecop.travel(30.seconds.from_now) do
        expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq true
      end
    end
  end

  context "#find_by_api_id" do
    it "returns nil if can't find" do
      expect(new_instance.find_by_api_id("notreal")).to be_nil
    end

    it "returns for existing app" do
      app_id = create_app("test_1").id
      expect(new_instance.find_by_api_id("test_1_api_id").id).to eq app_id
    end

    it "does not return for app added recently" do
      cached_apps = new_instance
      create_app("test_1")
      expect(cached_apps.find_by_api_id("test_1_api_id")).to be_nil
    end

    it "does return for app added more than 30 seconds ago" do
      cached_apps = new_instance
      app_id = create_app("test_1").id
      Timecop.travel(30.seconds.from_now) do
        expect(cached_apps.find_by_api_id("test_1_api_id").id).to eq app_id
      end
    end
  end

  context "#find_by_api_id!" do
    it "raises if not there" do
      expect{
        new_instance.find_by_api_id!("notreal")
      }.to raise_error(StandardError).with_message(/No app/)
    end
  end

  def create_app(name)
    App.create(name: name,
               api_id: "#{name}_api_id",
               api_token: "#{name}_api_token")
  end

end
