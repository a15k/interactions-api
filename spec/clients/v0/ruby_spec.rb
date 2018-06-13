require 'rails_helper'


describe 'Ruby client', type: :api do

  let(:api_id) { "a_valid_api_id" }
  let(:api_token) { "a_valid_api_token" }

  before(:each) {
    # Always create the app with the same ID and token so that the cached apps in the Capybara
    # server match up even tho redis is cleared after every example
    app = App.create(api_id: api_id, api_token: api_token, whitelisted_domains: ["openstax.org"])

    A15kInteractions.configure do |c|
      # c.debugging = true
      c.scheme = 'http'
      c.host = "localhost:#{api_server_port}/"
      c.api_key['Authorization'] = "ID #{app.api_id}"
    end
  }

  describe 'Interactions' do
    describe 'Apps' do
      let(:api_client) { A15kInteractions::AppsApi.new }
    end

    describe 'Flagging' do
      let(:api_client) { A15kInteractions::FlagsApi.new }
      let(:flag) {
        A15kInteractions::Flag.new(
          content_uid: SecureRandom.uuid, user_uid: SecureRandom.uuid, type: 'typo',
        )
      }
      let(:flag_response) { api_client.create_flag(flag) }

      it 'creating' do
        expect(flag_response).to be_a_kind_of(A15kInteractions::Flag)
      end

      it 'retrieval' do
        response = api_client.get_flag(flag_response.id)
        expect(response).to be_a_kind_of(A15kInteractions::Flag)
        expect(response.id).to eq flag_response.id
      end

      it 'deletion' do
        response = api_client.delete_flag(flag_response.id)
        expect(response).to be_a_kind_of(A15kInteractions::Flag)
      end
    end

  end
end
