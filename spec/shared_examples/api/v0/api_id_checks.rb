RSpec.shared_examples "v0 API ID checks" do |route_prefix:, actions:|

  let(:an_app_for_api_id_checks) do
    App.create.tap do |app|
      app.update(name: "whatever", whitelisted_domains: "openstax.org")
    end
  end

  context "missing API ID" do
    before { clear_api_id }
    before { set_origin("https://blah.openstax.org") }

    test_request_status(self, :post, "#{route_prefix}", :unauthorized) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :unauthorized)if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :unauthorized) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :unauthorized) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :unauthorized) if destroy?(actions)
  end

  context "missing origin" do
    before { clear_origin }
    before { set_api_id(an_app_for_api_id_checks.api_id) }

    test_request_status(self, :post, "#{route_prefix}", :unauthorized) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :unauthorized)if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :unauthorized) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :unauthorized) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :unauthorized) if destroy?(actions)
  end

  context "valid API ID and invalid origin" do
    before { set_api_id(an_app_for_api_id_checks.api_id) }
    before { set_origin("https://notright.io") }

    test_request_status(self, :post, "#{route_prefix}", :forbidden) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :forbidden) if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :forbidden) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :forbidden) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :forbidden) if destroy?(actions)
  end

  context "invalid API ID and valid origin" do
    before { set_api_id("notreal") }
    before { set_origin("https://blah.openstax.org") }

    test_request_status(self, :post, "#{route_prefix}", :forbidden) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :forbidden) if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :forbidden) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :forbidden) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :forbidden) if destroy?(actions)
  end

end
