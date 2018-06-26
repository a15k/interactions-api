module RedisModel

  def self.included(base)
    base.include ActiveModel::Serializers::JSON
    base.include ActiveModel::Validations
    base.include RedisConnection

    base.extend ClassMethods
  end

  module ClassMethods
    # Override the default redis_key by passing a proc that takes an `id`
    # field and returns the desired string key
    def set_redis_key_proc(proc)
      @redis_key_proc = proc
    end

    attr_reader :during_save_callbacks

    def during_save(callback)
      @during_save_callbacks ||= []
      @during_save_callbacks.push(callback)
    end

    attr_reader :during_destroy_callbacks

    def during_destroy(callback)
      @during_destroy_callbacks ||= []
      @during_destroy_callbacks.push(callback)
    end

    def redis_key(id)
      @redis_key_proc.nil? ? "#{self.name.pluralize.downcase}:id:#{id}" :
                             @redis_key_proc.call(id)
    end

    def find(id)
      return nil if id.blank?
      data = redis.get(redis_key(id))
      return nil if data.nil?
      new(persisted: true).from_json(data)
    end

    def find_all(*ids)
      ids = [ids].flatten
      return [] if ids.empty?

      datas = redis.mget(ids.map{|id| redis_key(id)})

      if datas.compact.length != ids.length
        missing_ids = datas.map.with_index {|data, ii| data.nil? ? ids[ii] : nil}.compact
        raise NotAllItemsFound, "Could not find #{self.name.pluralize} with IDs #{missing_ids}"
      end

      datas.map{|data| new(persisted: true).from_json(data)}
    end
  end

  def persisted?
    self.persisted
  end

  def attributes
    instance_values
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def redis_key
    self.class.redis_key(id)
  end

  def destroy
    redis.multi do
      redis.del(redis_key)

      self.class.during_destroy_callbacks.each do |callback|
        send(callback, redis, id)
      end
    end
  end

  protected

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

      self.class.during_save_callbacks.each do |callback|
        send(callback, redis, id)
      end
    end

    true
  end

end
