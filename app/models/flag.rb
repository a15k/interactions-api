require "kafka"  # TODO clean up these requires
require "avro_turf"
require 'avro_turf/messaging'

class Flag
  include ActiveModel::Serializers::JSON
  include RedisConnection

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  attr_reader :id, :app_id, :source_domain, :content_uid,
              :variant_id, :user_uid, :type, :explanation, :created_at

  def self.create(app_api_id:, source_domain:, content_uid:,
                  variant_id:, user_uid:, type:, explanation:)
    Flag.new(id: SecureRandom.uuid,
             app_id: CachedApps.instance.find_by_api_id!(app_api_id).id,
             source_domain: source_domain,
             content_uid: content_uid,
             variant_id: variant_id,
             user_uid: user_uid,
             type: type,
             explanation: explanation,
             created_at: Time.current.utc).tap(&:save)
    # TODO if create doesn't work the caller won't know
  end

  def self.find(id)
    return nil if id.blank?
    data = redis.get("flags:id:#{id}")
    return nil if data.nil?
    Flag.new.from_json(data)
  end

  def update(type: nil, explanation: nil)
    # Can update only one or neither
    self.type = type if type.present?
    self.explanation = explanation if explanation.present?
    save
  end

  def destroy
    redis.multi do
      redis.del(redis_key)
    end
  end

  def attributes
    instance_values
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  protected

  attr_writer :id, :app_id, :source_domain, :content_uid,
              :variant_id, :user_uid, :type, :explanation, :created_at

  def initialize(data = {})
    self.attributes = data
  end

  # `save` is protected because we always want to know what kind of
  # save is happening (create or update) so we can write the appropriate
  # entry into Kafka
  def save
    # TODO validations?
    redis.multi do
      redis.set(redis_key, to_json)
      # TODO also index ID by other fields as needed
    end
    true
  end

  def redis_key
    "flags:id:#{id}"
  end

end
