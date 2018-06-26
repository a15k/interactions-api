=begin
#Assessment Network Interactions API

#Records interactions with content distributed by the Assessment Network.  Requests to this API should include `application/json` in the `Accept` header.  The desired API version is specified in the request URL, e.g. `...a15k.org/v0/flags`.          While the API does support a default version, that version will change over          time and therefore should not be used in production code!  Some endpoints require an API key to be passed in the request header.  There are two          types of API keys: API tokens and API IDs.  An API token is used for more restricted          access.  Such tokens should not be shared with end users.  API IDs are used for less          restricted access and may be exposed to clients (e.g. through use in browser-side code).          Both keys are available to members through www.a15k.org. 

OpenAPI spec version: 0.1.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.3.1

=end

require "uri"

module A15kInteractions
  class AppsApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # Create a new app
    # Create a new app with some values pre-populated; does not take initial values
    # @param [Hash] opts the optional parameters
    # @option opts [String] :group_id ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once.
    # @return [App]
    def create_app(opts = {})
      data, _status_code, _headers = create_app_with_http_info(opts)
      return data
    end

    # Create a new app
    # Create a new app with some values pre-populated; does not take initial values
    # @param [Hash] opts the optional parameters
    # @option opts [String] :group_id ID under which the new app should be grouped (e.g. the UUID) of the app owner.  Can be used to later retrieve all apps in the same group at once.
    # @return [Array<(App, Fixnum, Hash)>] App data, response status code and response headers
    def create_app_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AppsApi.create_app ..."
      end
      # resource path
      local_var_path = "/apps"

      # query parameters
      query_params = {}
      query_params[:'group_id'] = opts[:'group_id'] if !opts[:'group_id'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'App')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AppsApi#create_app\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Delete an app
    # Delete the specified app
    # @param id ID of the app to delete
    # @param [Hash] opts the optional parameters
    # @return [App]
    def delete_app(id, opts = {})
      data, _status_code, _headers = delete_app_with_http_info(id, opts)
      return data
    end

    # Delete an app
    # Delete the specified app
    # @param id ID of the app to delete
    # @param [Hash] opts the optional parameters
    # @return [Array<(App, Fixnum, Hash)>] App data, response status code and response headers
    def delete_app_with_http_info(id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AppsApi.delete_app ..."
      end
      # verify the required parameter 'id' is set
      if @api_client.config.client_side_validation && id.nil?
        fail ArgumentError, "Missing the required parameter 'id' when calling AppsApi.delete_app"
      end
      # resource path
      local_var_path = "/apps/{id}".sub('{' + 'id' + '}', id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'App')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AppsApi#delete_app\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get a specific app
    # Returns all information about a specific app
    # @param id ID of the app
    # @param [Hash] opts the optional parameters
    # @return [App]
    def get_app(id, opts = {})
      data, _status_code, _headers = get_app_with_http_info(id, opts)
      return data
    end

    # Get a specific app
    # Returns all information about a specific app
    # @param id ID of the app
    # @param [Hash] opts the optional parameters
    # @return [Array<(App, Fixnum, Hash)>] App data, response status code and response headers
    def get_app_with_http_info(id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AppsApi.get_app ..."
      end
      # verify the required parameter 'id' is set
      if @api_client.config.client_side_validation && id.nil?
        fail ArgumentError, "Missing the required parameter 'id' when calling AppsApi.get_app"
      end
      # resource path
      local_var_path = "/apps/{id}".sub('{' + 'id' + '}', id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'App')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AppsApi#get_app\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get all apps matching a query
    # Get all apps matching a query.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :group_id ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps.
    # @return [Array<App>]
    def get_apps(opts = {})
      data, _status_code, _headers = get_apps_with_http_info(opts)
      return data
    end

    # Get all apps matching a query
    # Get all apps matching a query.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :group_id ID under which apps are grouped (e.g. the UUID) of the app owner.If not provided, returns all apps.
    # @return [Array<(Array<App>, Fixnum, Hash)>] Array<App> data, response status code and response headers
    def get_apps_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AppsApi.get_apps ..."
      end
      # resource path
      local_var_path = "/apps"

      # query parameters
      query_params = {}
      query_params[:'group_id'] = opts[:'group_id'] if !opts[:'group_id'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Array<App>')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AppsApi#get_apps\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Update an app
    # Update an app with the provided values.
    # @param id ID of the app
    # @param [Hash] opts the optional parameters
    # @option opts [AppUpdate] :app The app data
    # @return [App]
    def update_app(id, opts = {})
      data, _status_code, _headers = update_app_with_http_info(id, opts)
      return data
    end

    # Update an app
    # Update an app with the provided values.
    # @param id ID of the app
    # @param [Hash] opts the optional parameters
    # @option opts [AppUpdate] :app The app data
    # @return [Array<(App, Fixnum, Hash)>] App data, response status code and response headers
    def update_app_with_http_info(id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AppsApi.update_app ..."
      end
      # verify the required parameter 'id' is set
      if @api_client.config.client_side_validation && id.nil?
        fail ArgumentError, "Missing the required parameter 'id' when calling AppsApi.update_app"
      end
      # resource path
      local_var_path = "/apps/{id}".sub('{' + 'id' + '}', id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(opts[:'app'])
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'App')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AppsApi#update_app\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
