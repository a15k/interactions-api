# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

require "kafka_helpers"
require "redis_connection"
