require_relative '../../rails_helper'


describe 'Ruby client', type: :api do

  before(:each) {
    A15kInteractions.configure do |c|
      c.scheme = 'http'
      c.debugging = true
      c.host = "localhost:#{api_server_port}/"
      c.api_key['Authorization'] = "Token #{app.api_token}"
    end
  }

  let(:app) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  describe 'Interactions' do
    let(:api_client) { A15kInteractions::FlagsApi.new }

    let(:existing_flag) {
      Flag.create(
        app_api_id: app.api_id,
        source_domain: app.whitelisted_domains.first,
        content_uid: SecureRandom.uuid,
        user_uid: SecureRandom.uuid,
        variant_id: nil,
        explanation: 'this one is baaaddd',
        type: 'typo'
      )
    }

    describe 'Flagging' do
      it 'can creating' do
        flag = A15kInteractions::Flag.new(
          content_uid: SecureRandom.uuid,
          user_uid: SecureRandom.uuid,
          type: 'typo')
        response = api_client.create_flag(flag)
        expect(response).to be_a_kind_of(A15kInteractions::Flag)
      end

      it 'retrieval' do
        response = api_client.get_flag(existing_flag.id)
        expect(response).to be_a_kind_of(A15kInteractions::Flag)
      end

      it 'deletion' do
        response = api_client.delete_flag(existing_flag.id)
        expect(response).to be_a_kind_of(A15kInteractions::Flag)
      end
    end

  end

end
