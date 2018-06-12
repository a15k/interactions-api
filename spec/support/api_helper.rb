require "capybara/rspec"
require 'capybara/rails'


# a mock driver that contains just enough code to
# force capybara to startup the webserver
class ApiDriver < Capybara::Driver::Base
  def needs_server?; true; end
  def visit(path); end
end

Capybara.register_driver :api do |app|
  ApiDriver.new
end

Capybara.configure do |config|
  config.run_server = true
  config.server = :puma, { Silent: true }
end

module ApiHelpers

  def api_server_port
    Capybara::Server.ports[Capybara.app.object_id]
  end

end

RSpec.configure do |config|
  config.include Capybara::DSL, type: :api
  config.include ApiHelpers, type: :api
end
