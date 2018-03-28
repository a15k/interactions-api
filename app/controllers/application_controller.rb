require 'celluloid/current'

class ApplicationController < ActionController::API

  before_action :initialize_apps

  protected

  def initialize_apps
    Thread.current[:apps] ||= Apps.new
  end

  def kafka
    Thread.current[:kafka_client] ||= Kafka.new(["localhost:9092"], client_id: "interactions-api_#{SecureRandom.uuid}", logger: Rails.logger)
  end

  def kafka_producer
    Thread.current[:kafka_producer] ||= begin
      kafka.async_producer(delivery_interval: 10).tap do |producer|
        at_exit { producer.shutdown }
      end
    end
  end

  # def apps

  # end

  # def settings

  # end

  # def kafka_consumer
  #   Thread.current[:kafka_consumer] ||= begin
  #     kafka.consumer.tap do |consumer|
  #       consumer.subscribe("apps")
  #       at_exit { consumer.stop }
  #     end
  #   end
  # end

  # def update_apps
  #   update_apps! if apps_last_updated_at.nil? ||
  #                   apps_last_updated_at > Time.current + settings[:app_refresh_period]
  # end

  # def update_apps!
  #   # read in batches
  #   apps_last_updated_at = Time.current
  # end

  # def apps_last_updated_at
  #   Thread.current[:apps_last_updated_at]
  # end

  # def apps_last_updated_at=(time)
  #   Thread.current[:apps_last_updated_at] = time
  # end

  # def update_settings

  # end

  # def update_settings!

  # end

  # def apps

  # end

  # def settings
  #   Thread.current[:settings] ||= {
  #     app_refresh_period: 10.seconds,
  #     settings_refresh_period: 10.seconds,
  #   }
  # end

end
