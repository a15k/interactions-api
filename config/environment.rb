# Load the Rails application.
require_relative 'application'

require "exceptions"
require "kafka_helpers"
require "redis_connection"
require "swagger_blocks_extensions"

# Initialize the Rails application.
Rails.application.initialize!
