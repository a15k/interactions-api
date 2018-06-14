require_relative '../../rails_helper'
require 'open3'


describe 'Javascript client', type: :api_client do
  let(:api_id) { "a_valid_api_id" }
  let(:api_token) { "a_valid_api_token" }

  let!(:app) do
    App.create(
      api_id: api_id, api_token: api_token, whitelisted_domains: ["openstax.org"]
    )
  end

  def exec(script, *args)
    path = Pathname.new(__FILE__).dirname.join('js', "#{script}.js")
    cmd = "node #{path} #{api_server_port} #{app.api_id} #{args.join(' ')}"
    stdout, stderr, status = Open3.capture3(cmd)
    expect(stderr).to be_empty
    expect(stdout).not_to be_empty
    expect(status).to eq 0
    stdout.chomp
  end

  describe 'Flagging' do
    it 'works' do
      uuid = SecureRandom.uuid
      id = exec('flags', uuid)
      expect(Flag.find(id)).to_not be_nil
    end
  end

end
