require 'redis-namespace'

module RedisConnection

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def redis
      Thread.current[:redis] ||= begin
        secrets = Rails.application.secrets.redis

        Redis::Namespace.new(
          secrets[:namespaces][:main],
          redis: Redis.new(url: secrets[:url])
        )
      end
    end
  end

  def redis
    self.class.redis
  end

end
