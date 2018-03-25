class Docs::V1Controller < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Assessment Network Metrics API'
      key :description, <<-DESC
>
Records feedback on and interactions with content distributed by the Assessment Network

TBD more information on setting headers
      DESC
      key :termsOfService, 'http://a15k.org/terms/'
      contact do
        key :name, 'info@a15k.org'
      end
      license do
        key :name, 'MIT'
      end
    end
    security_definition :api_key do
      key :type, :apiKey
      key :name, :api_token
      key :in, :header
    end
    key :host, 'metrics.a15k.org'
    key :basePath, '/api'
    key :consumes, ['application/vnd.a15k+json;version=1']
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
    Api::V1::FlagsController,
    Api::V1::SwaggerModels,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
