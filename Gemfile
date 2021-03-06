source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'ruby-kafka'
gem 'avro_turf'

gem "versionist"

gem "swagger-blocks"

gem "oj"
gem "oj_mimic_json"

gem 'redis'
gem "redis-namespace"

gem "openstax_healthcheck"

gem "aws-sdk-ssm"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Use RSpec for tests
  gem 'rspec-rails'

  gem 'database_cleaner'

  gem 'timecop'
  gem "fakeredis", :require => "fakeredis/rspec"

  gem "codecov", require: false
  gem "parallel_tests"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'a15k_interactions_api', path: './clients/0.1.0/ruby'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
