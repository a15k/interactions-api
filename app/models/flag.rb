require "kafka"  # TODO clean up these requires
require "avro_turf"
require 'avro_turf/messaging'

class Flag
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations

  include RedisConnection

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  DATA_FIELDS = [:id, :app_id, :source_domain, :content_uid,
                 :variant_id, :user_uid, :type, :explanation,
                 :created_at]

  attr_reader *DATA_FIELDS

  validates :id, presence: true
  validates :app_id, presence: true
  validates :source_domain, presence: true
  validates :content_uid, presence: true
  validates :user_uid, presence: true
  validates :type, presence: true,
                   inclusion: { in: %w(unspecified typo copyright_violation incorrect offensive) }
  validates :created_at, presence: true

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
  end

  def self.find(id)
    return nil if id.blank?
    data = redis.get(redis_key(id))
    return nil if data.nil?
    Flag.new(persisted: true).from_json(data)
  end

  def self.find_all(*ids)
    ids = [ids].flatten
    return [] if ids.empty?

    datas = redis.mget(ids.map{|id| redis_key(id)})

    if datas.compact.length != ids.length
      missing_ids = datas.map.with_index {|data, ii| data.nil? ? ids[ii] : nil}.compact
      raise NotAllItemsFound, "Could not find Flags with IDs #{missing_ids}"
    end

    datas.map{|data| Flag.new(persisted: true).from_json(data)}
  end

  def self.search(content_uid:, variant_id:, app_id:, user_uid:)
    ids = redis.smembers(presentation_key(content_uid: content_uid,
                                          variant_id: variant_id,
                                          app_id: app_id,
                                          user_uid: user_uid))
    begin
      find_all(ids)
    rescue NotAllItemsFound => ee
      raise "Search for #{content_uid}, #{variant_id}, #{app_id}, #{user_uid} " \
            "yielded IDs not all of which were found: #{ee.message}"
    end
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
      redis.srem(presentation_key, id)
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

  def persisted?
    self.persisted
  end

  protected

  attr_writer *DATA_FIELDS
  attr_accessor :persisted

  def initialize(data = {})
    self.attributes = data
  end

  # `save` is protected because it will be easier to write create- and update-
  # specific records to Kafka when callers have to use public create and update
  # methods.
  def save
    return false if invalid?

    redis.multi do
      redis.set(redis_key, to_json)

      if !persisted?
        redis.sadd(presentation_key, id)
      end
    end

    true
  end

  def to_json
    as_json(only: DATA_FIELDS).to_json
  end

  def redis_key
    self.class.redis_key(id)
  end

  def self.redis_key(id)
    "flags:id:#{id}"
  end

  def presentation_key
    self.class.presentation_key(content_uid: content_uid,
                                variant_id: variant_id,
                                app_id: app_id,
                                user_uid: user_uid)
  end

  def self.presentation_key(content_uid:, variant_id:, app_id:, user_uid:)
    "flags:c:#{content_uid}:v:#{variant_id}:a:#{app_id}:u:#{user_uid}"
  end

end
