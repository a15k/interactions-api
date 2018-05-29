require 'uri'

class Docs::V0Controller < ApplicationController
  include Swagger::Blocks

  ACCEPT_HEADER = 'application/json'

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '0.1.0'
      key :title, 'Assessment Network Interactions API'
      key :description, <<~DESC
          >
          Records interactions with content distributed by the Assessment Network

          Requests to this API should include `#{ACCEPT_HEADER}` in the
          `Accept` header.

          The desired API version is specified in the request URL, e.g. `...a15k.org/v0/flags`.
          While the API does support a default version, that version will change over
          time and therefore should not be used in production code!

          Some endpoints require an API key to be passed in the request header.  There are two types of
          API keys: API tokens and API IDs.  An API token is used for more restricted access.  Such tokens
          should not be shared with end users.  API IDs are used for less restricted access and may be exposed
          to clients (e.g. through use in browser-side code).  Both keys are available to members through
          www.a15k.org.
      DESC
      key :termsOfService, 'http://a15k.org/terms/'
      contact do
        key :name, 'info@a15k.org'
      end
      license do
        key :name, 'MIT'
      end
    end
    security_definition :api_token do
      key :type, :apiKey
      key :name, :'Authorization'
      key :in, :header
    end
    security_definition :api_id do
      key :type, :apiKey
      key :name, :'Authorization'
      key :in, :header
    end
    tag do
      key :name, 'Apps'
      key :description, 'Some API endpoints are limited to approved applications.  These endpoints ' \
                        'manage these applications and are restricted to system administrators.'
    end
    tag do
      key :name, 'Flags'
      key :description, ''
    end
    # key :host, URI.parse(Rails.application.secrets.base_url).host
    key :basePath, '/api/v0'
    key :consumes, [ACCEPT_HEADER]
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    Api::V0::FlagsController,
    Api::V0::SwaggerModels,
    Api::V0::AppsController,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
