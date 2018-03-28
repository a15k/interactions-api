module KafkaHelpers

  KAFKA_BROKERS = ["localhost:9092"]

  def self.new_client(name:)
    Kafka.new(KAFKA_BROKERS, client_id: "interactions-api_#{name}_#{SecureRandom.uuid}", logger: Rails.logger)
  end

end
