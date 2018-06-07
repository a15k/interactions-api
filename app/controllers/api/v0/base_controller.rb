class Api::V0::BaseController < ApplicationController

  protected

  def bind(data, bindings_class)
    begin
      # Some swagger types are simple scalars and some are arrays or other
      # For arrays, when we call permit, we need to call it with `:key_name => []`
      # Use the `swagger_types` data in the bindings class to find those cases
      # and generate the correct arguments to pass to `permit`.

      data_hash = data.permit(bindings_class.swagger_types.map { |k,v|
        v.to_s.starts_with?("Array") ? {k => []} : k
      }).to_h

      binding = bindings_class.new(data_hash)

      # do some simple extra error checking
      keys_in_binding = binding.to_body.keys.map(&:to_s)
      keys_in_data = data.keys.map(&:to_s)

      unused_keys = keys_in_data - keys_in_binding
      bad_keys = unused_keys & bindings_class.swagger_types.keys.map(&:to_s)
      unrequested_keys = unused_keys - bad_keys

      if bad_keys.any?
        # NB: Some other things can generate ArgumentError besides this
        raise ArgumentError, "Some keys caused errors: #{bad_keys}"
      end
    rescue ArgumentError => ee
      return [nil, Api::V0::Bindings::Error.new(status_code: 422, messages: [ee.message])]
    end

    return [binding, nil] if binding.valid?

    [binding, Api::V0::Bindings::Error.new(status_code: 422,
                                           messages: binding.list_invalid_properties)]
  end

  def api_token
    request.headers['Authorization'].try(:match, /Token\s*(\S+)/).try(:[],1)
  end

  def api_id
    request.headers['Authorization'].try(:match, /ID\s*(\S+)/).try(:[],1)
  end

  def origin
    request.headers['origin']
  end

  def origin_host
    URI.parse(origin).host
  end

  def origin!
    origin || raise(MissingOrigin)
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
    begin
      return head(:unauthorized) if api_id.nil?
      return head(:forbidden) if !apps.does_api_id_origin_combo_exist?(api_id, origin!)
    rescue MissingOrigin => ee
      return head(:unauthorized)
    end
  end

  def apps
    CachedApps.instance
  end

end
