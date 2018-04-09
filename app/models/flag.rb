require "kafka"  # TODO clean up these requires
require "avro_turf"
require 'avro_turf/messaging'

class Flag
  include ActiveModel::Serializers::JSON

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  def self.create
    raise "NYI"
  end

  def self.find(id)
    raise "NYI"
  end

  def update
    raise "NYI"
  end

  def destroy
    raise "NYI"
  end

end
