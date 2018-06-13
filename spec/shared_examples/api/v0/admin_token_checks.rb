RSpec.shared_examples "v0 admin token checks" do |route_prefix:, actions:|

  context "invalid admin token" do
    before { set_bad_admin_api_token }

    test_crud_request_status(self, route_prefix, :forbidden, actions)

    context "but good API ID" do
      before do
        app = App.create.tap do |app|
          app.update(name: "whatever", whitelisted_domains: "openstax.org")
        end
        set_api_id(app.api_id)
      end

      # Setting API ID when not asked will give unauthorized
      test_crud_request_status(self, route_prefix, :unauthorized, actions)
    end
  end

  context "missing admin token" do
    before { clear_api_token }

    test_crud_request_status(self, route_prefix, :unauthorized, actions)

    context "but good API ID" do
      before do
        app = App.create.tap do |app|
          app.update(name: "whatever", whitelisted_domains: "openstax.org")
        end
        set_api_id(app.api_id)
      end

      test_crud_request_status(self, route_prefix, :unauthorized, actions)
    end
  end
end
