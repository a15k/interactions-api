module PresentableModel

  def self.included(base)
    base.extend ClassMethods

    base.during_save :add_to_presentation_index
    base.during_destroy :remove_from_presentation_index
  end

  module ClassMethods
    def search(content_uid:, variant_id:, app_id:, user_uid:)
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

    def presentation_key(content_uid:, variant_id:, app_id:, user_uid:)
      "#{self.name.pluralize.downcase}:c:#{content_uid}:v:#{variant_id}:a:#{app_id}:u:#{user_uid}"
    end
  end

  def presentation_key
    self.class.presentation_key(content_uid: content_uid,
                                variant_id: variant_id,
                                app_id: app_id,
                                user_uid: user_uid)
  end

  def remove_from_presentation_index(redis, id)
    redis.srem(presentation_key, id)
  end

  def add_to_presentation_index(redis, id)
    redis.sadd(presentation_key, id) if !persisted?
  end


end
