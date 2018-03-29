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

  swagger_schema :App do
    key :required, [:id, :name, :api_id, :api_token]
    property :id do
      key :type, :string
      key :readOnly, true
      key :description, "Internal ID"
    end
    property :name do
      key :type, :string
      key :description, "Custom name set by app owner to help them manage apps"
    end
    property :api_id do
      key :type, :string
      key :readOnly, true
      key :description, "Used to identify the app in unsecured API requests"
    end
    property :api_token do
      key :type, :string
      key :description, "Used to identify the app in secured API requests, normally as part of the HTTP header"
    end
    property :whitelisted_domains do
      key :type, :array
      key :description, "List of domains that should be allowed to make cross-origin AJAX requests"
      items do
        key :type, :string
      end
    end
  end

  swagger_schema :Error do
    property :messages do
      key :type, :array
      key :description, "The error messages, if any"
      items do
        key :type, :string
      end
    end
  end

end
