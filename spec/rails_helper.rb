# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

require 'database_cleaner'

# DatabaseCleaner[:redis] = redis #{ }"redis://localhost:6379/0"

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  redis_namespace = Rails.application.secrets.redis[:namespaces][:main]

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation, {only: ["#{redis_namespace}:*"]}
    DatabaseCleaner.clean_with(:truncation, only: ["#{redis_namespace}:*"])
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Inject the correct accept header in routing specs
  config.before(:example, accept: :v1, type: :routing) do
    expect(Rack::MockRequest).to receive(:env_for).and_wrap_original do |original_method, *args, &block|
      original_method.call(*args, &block).tap { |hash| hash['HTTP_ACCEPT'] = accept_header }
    end
  end

  config.before(:example, accept: :v1, type: :request) do
    headers["ACCEPT"] = accept_header
  end

  # config.before(:example) do
  #   App.all.each(&:delete)
  # end

  config.include JsonHelpers, type: :request
end

def accept_header
  version = self.class.metadata[:accept]

  return if version.nil?

  "Docs::#{version.upcase}Controller::ACCEPT_HEADER".constantize
end

def set_admin_api_token
  set_api_token(Rails.application.secrets.admin_api_token)
end

def set_bad_admin_api_token
  set_api_token("intentionally_bad_value")
end

def set_api_token(value)
  headers['X-API-TOKEN'] = value
end

def headers
  @headers ||= {}
end
