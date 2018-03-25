require "kafka"
require "byebug"
require "avro_turf"
require 'avro_turf/messaging'

# curl -X POST -H "Accept: application/vnd.a15k.v1" http://localhost:3000/events

class V1::EventsController < ApplicationController

  def create
    # Rails.logger.info("Hi!")
    # debugger
    # logger = Logger.new("log/kafka.log")
    # debugger
    # kafka.del
    debugger
    # kafka = Kafka.new(["localhost:9092"], client_id: "metrics-api_#{SecureRandom.hex(3)}", logger: Rails.logger)

    # kafka.deliver_message("Hello, World!", topic: "greetings")

    avro = AvroTurf::Messaging.new(registry_url: "http://localhost:8081/", schemas_path: "app/schemas", namespace: "org.a15k")

    # Encoding data has the side effect of registering the schema. This only
    # happens the first time a schema is used with the instance of `AvroTurf`.
    data = avro.encode({ "flag_type" => "typo", "app_id" => "blah" }, schema_name: "flagged_content")

    kafka_producer.produce(data, topic: "greetings")
  end


end
