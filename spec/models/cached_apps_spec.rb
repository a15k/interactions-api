require 'rails_helper'

RSpec.describe CachedApps do

  context "#does_api_token_exist?" do
    it "returns true if it does exist" do
      create_app("test_1")
      expect(CachedApps.new.does_api_token_exist?("test_1_api_token")).to eq true
    end

    it "returns false is it doesn't exist" do
      expect(CachedApps.new.does_api_token_exist?("unknown_token")).to eq false
    end

    it "returns false if exists but was added recently" do
      cached_apps = CachedApps.new
      create_app("test_1")
      expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq false
    end

    it "returns true if does not exist but was removed recently" do
      app = create_app("test_1")
      cached_apps = CachedApps.new
      app.destroy
      expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq true
    end

    it "returns true if exists and was added more than 30 seconds ago" do
      cached_apps = CachedApps.new
      create_app("test_1")
      Timecop.travel(30.seconds.from_now) do
        expect(cached_apps.does_api_token_exist?("test_1_api_token")).to eq true
      end
    end
  end

  def create_app(name)
    App.create(name: name,
               api_id: "#{name}_api_id",
               api_token: "#{name}_api_token")
  end

end
