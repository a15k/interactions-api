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

  def controller_spec?
    self.class.metadata[:type] == :controller
  end

  def request_spec?
    self.class.metadata[:type] == :request
  end

  def set_api_token(value)
    # hash = if controller_spec?
    #   @request.headers
    # elsif request_spec?
    #   headers
    # end

    # hash['Authorization'] = "Token #{value}"
    set_authorization_header("Token #{value}")
  end

  def set_api_id(value)
    set_authorization_header("ID #{value}")
    # headers['Authorization'] = "ID #{value}"
  end

  def set_authorization_header(value)
    # hash = if controller_spec?
    #   @request.headers
    # elsif request_spec?
    #   headers
    # end

    # hash['Authorization'] = value
    set_header('Authorization', value)
  end

  def set_header(key, value)
    hash = if controller_spec?
      @request.headers
    elsif request_spec?
      headers
    end

    hash[key] = value
  end

  def set_origin(value)
    set_header('origin', value)
    # headers['origin'] = value
  end

  def headers
    @headers ||= {}
  end

  def clear_headers
    @headers = nil
  end

  def api_post(*args, &block)
    post(*prep_request_args(args), &block)
  end

  def api_get(*args, &block)
    get(*prep_request_args(args), &block)
  end

  def api_put(*args, &block)
    get(*prep_request_args(args), &block)
  end

  def api_delete(*args, &block)
    get(*prep_request_args(args), &block)
  end

  def add_path_prefix(args)
    args.dup.tap {|copy| copy[0] = "/api/v0/#{copy[0]}"}
  end

  def prep_request_args(args)
    args.dup.tap do |copy|
      copy[0] = "/api/v0/#{copy[0]}"

      # Add the headers on to the end or merge them with existing hash
      if copy.length == 1
        copy.push({headers: headers})
      else
        if copy[1].is_a?(Hash)
          copy[1][:headers] = headers.merge(copy[1][:headers] || {})
        else
          raise "Don't know what to do with this case"
        end
      end
    end
  end

  def self.more_rspec_config(config)
    config.before(:example, api: :v0) do
      clear_headers
    end
  end

end
