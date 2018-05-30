class Api::V0::BaseController < ApplicationController

  protected

  def bind(data, bindings_class)
    begin
      binding = bindings_class.new(data)
    rescue ArgumentError => ee
      return [nil, Api::V0::Error.new(status_code: 422, messages: [ee.message])]
    end

    return [binding, nil] if binding.valid?

    [binding, Api::V0::Error.new(status_code: 422, messages: ee.list_invalid_properties)]
  end

  def api_token
    request.headers['Authorization'].try(:match, /Token\W*(\w+)/).try(:[],1)
  end

  def api_id
    request.headers['Authorization'].try(:match, /ID\W*(\w+)/).try(:[],1)
  end

  def origin
    request.headers['origin']
  end

  def authenticate_admin_api_token
    return head(:unauthorized) if api_token.nil?
    return head(:forbidden) if api_token != Rails.application.secrets.admin_api_token
  end

  def authenticate_api_token
    return head(:unauthorized) if api_token.nil?
    return head(:forbidden) if !apps.does_api_token_exist?(api_token)
  end

  def authenticate_api_id_and_domain
    return head(:unauthorized) if api_id.nil?
    return head(:forbidden) if !apps.does_api_id_origin_combo_exist?(api_id, origin)
  end

  def apps
    Thread.current[:apps] ||= CachedApps.new
  end

end
