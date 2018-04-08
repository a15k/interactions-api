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

end
