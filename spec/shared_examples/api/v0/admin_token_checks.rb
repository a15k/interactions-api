RSpec.shared_examples "v0 admin token checks" do |route_prefix:, actions:|

  context "invalid admin token" do
    before { set_bad_admin_api_token }

    test_request_status(self, :post, "#{route_prefix}", :forbidden) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :forbidden) if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :forbidden) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :forbidden) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :forbidden) if destroy?(actions)
  end

  context "missing admin token" do
    before { clear_api_token }

    test_request_status(self, :post, "#{route_prefix}", :unauthorized) if create?(actions)
    test_request_status(self, :get, "#{route_prefix}/42", :unauthorized)if show?(actions)
    test_request_status(self, :get, "#{route_prefix}", :unauthorized) if index?(actions)
    test_request_status(self, :put, "#{route_prefix}/42", :unauthorized) if update?(actions)
    test_request_status(self, :delete, "#{route_prefix}/42", :unauthorized) if destroy?(actions)
  end

end
