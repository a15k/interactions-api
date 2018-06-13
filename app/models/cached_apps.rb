require 'ostruct'

class CachedApps

  REFRESH_PERIOD = 30.seconds

  def self.instance
    Thread.current[:apps] ||= new
  end

  def initialize
    refresh!
  end

  def does_api_token_exist?(api_token)
    find_by_api_token(api_token).present?
  end

  def does_api_id_exist?(api_id)
    find_by_api_id(api_id).present?
  end

  def does_api_id_origin_combo_exist?(api_id, origin)
    app = find_by_api_id(api_id)
    app.present? && app.url_is_whitelisted?(origin)
  end

  def find_by_api_token(api_token)
    refresh_if_needed!
    @apps.by_api_token[api_token]
  end

  def find_by_api_id(api_id)
    refresh_if_needed!
    @apps.by_api_id[api_id]
  end

  def find_by_api_id!(api_id)
    find_by_api_id(api_id) || (raise AppNotFound, "No app with API ID '#{api_id}")
  end

  def refresh_if_needed!
    refresh! if @marked_stale || @last_refreshed_at < REFRESH_PERIOD.ago
  end

  def refresh!
    @apps = OpenStruct.new(by_api_token: {}, by_api_id: {})

    apps = App.search
    apps.each do |app|
      @apps.by_api_token[app.api_token] = app
      @apps.by_api_id[app.api_id] = app
    end

    @marked_stale = false
    @last_refreshed_at = Time.current
  end

  def mark_stale!
    @marked_stale = true
  end

  def api_ids
    @apps.by_api_id.keys
  end

  def api_tokens
    @apps.by_api_token.keys
  end

end
