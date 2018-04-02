require 'uri'

class Docs::V1Controller < ApplicationController
  include Swagger::Blocks

  ACCEPT_HEADER = 'application/vnd.interactions.a15k.org; version=1'

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Assessment Network Interactions API'
      key :description, <<~DESC
          >
          Records interactions with content distributed by the Assessment Network

          Requests to this API should include `application/vnd.interactions.a15k.org; version=1` in the
          `Accept` header.  While the API does support a default version, that version will change over
          time and therefore should not be used in production code!

          A few endpoints require an API key to be passed in the request header.  These keys are available to members through www.a15k.org.
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
      key :name, :'X-API-TOKEN'
      key :in, :header
    end
    tag do
      key :name, 'Apps'
      key :description, 'Some API endpoints are limited to approved applications.  These endpoints ' \
                        ' manage these applications and are restricted to system administrators.'
    end
    tag do
      key :name, 'Flags'
      key :description, ''
    end
    key :host, URI.parse(Rails.application.secrets.base_url).host
    key :basePath, '/api'
    key :consumes, [ACCEPT_HEADER]
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    Api::V1::FlagsController,
    Api::V1::SwaggerModels,
    Api::V1::AppsController,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
