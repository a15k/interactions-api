RSpec.shared_examples "v0 API ID checks" do |route_prefix:, actions:|

  let(:an_app_for_api_id_checks) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  context "missing API ID" do
    before { clear_api_id }
    before { set_origin("https://blah.openstax.org") }

    test_crud_request_status(self, route_prefix, :unauthorized, actions)
  end

  context "valid API ID and invalid origin" do
    before { set_api_id(an_app_for_api_id_checks.api_id) }
    before { set_origin("https://notright.io") }

    test_crud_request_status(self, route_prefix, :forbidden, actions)
  end

  context "invalid API ID and valid origin" do
    before { set_api_id("notreal") }
    before { set_origin("https://blah.openstax.org") }

    test_crud_request_status(self, route_prefix, :forbidden, actions)
  end

end
