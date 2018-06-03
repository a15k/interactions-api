# Load the Rails application.
require_relative 'application'

require "exceptions"
require "kafka_helpers"
require "redis_connection"

# Initialize the Rails application.
Rails.application.initialize!
