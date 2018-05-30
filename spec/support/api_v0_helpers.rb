module ApiV0Helpers

  def set_admin_api_token
    set_api_token(Rails.application.secrets.admin_api_token)
  end

  def set_bad_admin_api_token
    set_api_token("intentionally_bad_value")
  end

  def set_bad_api_id
    set_api_id("intentionally_bad_value")
  end

  def set_api_token(value)
    headers['Authorization'] = "Token #{value}"
  end

  def set_api_id(value)
    headers['Authorization'] = "ID #{value}"
  end

  def headers
    @headers ||= {}
  end

  def clear_headers
    @headers = nil
  end

  def self.more_rspec_config(config)
    config.before(:example, api: :v0) do
      clear_headers
    end
  end

end
