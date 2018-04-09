module KafkaHelpers

  KAFKA_BROKERS = ["localhost:9092"]

  def self.new_client(name:)
    Kafka.new(KAFKA_BROKERS, client_id: "interactions-api_#{name}_#{SecureRandom.uuid}", logger: Rails.logger)
  end

  # def kafka_consumer
  #   Thread.current[:kafka_consumer] ||= begin
  #     kafka.consumer.tap do |consumer|
  #       consumer.subscribe("apps")
  #       at_exit { consumer.stop }
  #     end
  #   end
  # end

  # def kafka
  #   Thread.current[:kafka_client] ||= Kafka.new(["localhost:9092"], client_id: "interactions-api_#{SecureRandom.uuid}", logger: Rails.logger)
  # end

  # def kafka_producer
  #   Thread.current[:kafka_producer] ||= begin
  #     kafka.async_producer(delivery_interval: 10).tap do |producer|
  #       at_exit { producer.shutdown }
  #     end
  #   end
  # end

    # Some Kafka playing:
    # # kafka = Kafka.new(["localhost:9092"], client_id: "interactions-api_#{SecureRandom.hex(3)}", logger: Rails.logger)
    # # kafka.deliver_message("Hello, World!", topic: "greetings")

    # avro = AvroTurf::Messaging.new(registry_url: "http://localhost:8081/", schemas_path: "app/schemas", namespace: "org.a15k")

    # # Encoding data has the side effect of registering the schema. This only
    # # happens the first time a schema is used with the instance of `AvroTurf`.
    # data = avro.encode({ "flag_type" => "typo", "app_id" => "blah" }, schema_name: "flagged_content")

    # kafka_producer.produce(data, topic: "greetings")

end
