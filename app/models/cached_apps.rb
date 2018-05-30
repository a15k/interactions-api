require 'ostruct'

class CachedApps

  REFRESH_PERIOD = 30.seconds

  def initialize
    refresh!
  end

  def does_api_token_exist?(api_token)
    refresh_if_old!
    @apps.by_api_token[api_token].present?
  end

  def does_api_id_origin_combo_exist?(api_id, origin)
    refresh_if_old!
    app = @apps.by_api_id[api_id]
    app.present? && app.url_is_whitelisted?(origin)
  end

  def refresh_if_old!
    refresh! if @last_refreshed_at < REFRESH_PERIOD.ago
  end

  def refresh!
    @apps = OpenStruct.new(by_api_token: {}, by_api_id: {})

    apps = App.search
    apps.each do |app|
      @apps.by_api_token[app.api_token] = app
      @apps.by_api_id[app.api_id] = app
    end

    @last_refreshed_at = Time.current
  end

end
