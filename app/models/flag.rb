require "kafka"  # TODO clean up these requires
require "avro_turf"
require 'avro_turf/messaging'

class Flag
  include ActiveModel::Serializers::JSON

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  attr_reader :id, :app_api_id, :source_domain, :content_uid,
              :variant_id, :user_uid, :type, :explanation

  def self.create(app_api_id:, source_domain:, content_uid:,
                  variant_id:, user_uid:, type:, explanation:)
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

  protected

  attr_writer :id, :app_api_id, :source_domain, :content_uid,
              :variant_id, :user_uid, :type, :explanation

  def initialize(id:, app_api_id:, source_domain:, content_uid:,
                 variant_id:, user_uid:, type:, explanation:)


  end

end
