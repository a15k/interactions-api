require_relative '../../rails_helper'


describe 'Ruby client', type: :api do

  let!(:app) do
    app = App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  before(:each) {
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
