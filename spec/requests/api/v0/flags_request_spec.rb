require "rails_helper"

RSpec.describe "Flags", :type => :request, api: :v0 do

  context "create" do
    it "gives forbidden for a bad API ID" do
      set_bad_api_id
      api_post 'flags'
      expect(response).to have_http_status(:forbidden)
    end

    it "gives unauthorized for a missing API ID" do
      # do not set any api ID
      api_post 'flags'
      expect(response).to have_http_status(:unauthorized)
    end

    context "valid API ID" do
      let(:app) do
        App.create(group_id: params[:group_id]).tap do |app|
          app.update(name: "whatever", whitelisted_domains: "openstax.org")
        end
      end

      context "valid domain" do
      #   set_origin("https://tutor.openstax.org")
      #   api_post "flags", params: flag_json(content)


      # :'content_uid' => :'content_uid',
      #   :'variant_id' => :'variant_id',
      #   :'user_uid' => :'user_uid',
      #   :'type' => :'type',
      #   :'explanation' => :'explanation'


        # expect(response).to have_http_status(:created)

        # bound_response = Api::V0::Bindings::App.new(json_response)

        # expect(bound_response.name).to be_blank
        # expect(bound_response.id).to be_a String
        # expect(bound_response.api_id.length).to be >= 8
        # expect(bound_response.api_token.length).to be >= 20
        # expect(bound_response.whitelisted_domains).to be_empty
      end

      context "invalid domain" do

      end
    end
  end

  # def flag_json(hash)
  #   Api::V0::Bindings::Flag.new.build_from_hash(hash).to_body.to_json
  # end

end
