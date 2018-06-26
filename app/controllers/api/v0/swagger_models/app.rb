module Api::V0::SwaggerModels::App
  include Swagger::Blocks
  include SwaggerBlocksExtensions

  swagger_schema :AppUpdate
  swagger_schema :App do
    key :required, [:id, :name, :api_id, :api_token]
  end

  add_properties(:App) do
    property :id do
      key :type, :string
      key :readOnly, true
      key :description, "Internally-set ID"
    end

    property :api_id do
      key :type, :string
      key :readOnly, true
      key :description, "Used to identify the app in unsecured API requests"
    end
    property :api_token do
      key :type, :string
      key :readOnly, true
      key :description, "Used to identify the app in secured API requests, normally as part of the HTTP header"
    end
    property :group_id do
      key :type, :string
      key :readOnly, true
      key :description, "Used to group apps"
    end
  end

  add_properties(:AppUpdate, :App) do
    property :name do
      key :type, :string
      key :description, "Custom name set by app owner to help them manage apps"
    end
    property :whitelisted_domains do
      key :type, :array
      key :description, "List of domains that should be allowed to make cross-origin AJAX requests"
      items do
        key :type, :string
      end
    end
  end

end
