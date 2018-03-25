module Api::V1::SwaggerModels
  include Swagger::Blocks

  swagger_schema :Flag do
    key :required, [:app_uid, :content_uid]
    property :app_uid do
      key :type, :string
    end
    property :content_uid do
      key :type, :string
    end
  end


end
