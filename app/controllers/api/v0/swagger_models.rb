module Api::V0::SwaggerModels
  include Swagger::Blocks
  include SwaggerBlocksExtensions

  swagger_schema :FlagNew do
    key :required, [:content_uid, :user_uid, :type]
  end

  swagger_schema :Flag do
    key :required, [:id, :content_uid, :user_uid, :type]
  end

  add_properties(:Flag) do
    property :id do
      key :type, :string
      key :readOnly, true
      key :description, "Internally-set UUID.  Used to retrieve and delete flags, so treat it as somewhat secret."
    end
  end

  add_properties(:FlagNew, :Flag) do
    property :content_uid do
      key :type, :string
      key :readOnly, true
      key :description, "The a15k ID of the content being flagged."
    end
    property :content_uid do
      key :type, :string
      key :readOnly, true
      key :description, "The a15k ID of the content being flagged."
    end
    property :variant_id do
      key :type, :string
      key :readOnly, true
      key :description, "The variant ID, only needed for generative assessments"
    end
    property :user_uid do
      key :type, :string
      key :readOnly, true
      key :description, "The ID of the user doing the flagging, unique in the " \
                        "scope of the reporting app"
    end
    property :type do
      key :type, :string
      key :description, "The type of flag"
      key :enum, [
        :unspecified, :typo, :copyright_violation, :incorrect, :offensive
      ]
    end
    property :explanation do
      key :type, :string
      key :description, "The end-user's explanation of why they added this flag."
    end
  end

  swagger_schema :App do
    key :required, [:id, :name, :api_id, :api_token]
    property :id do
      key :type, :string
      key :readOnly, true
      key :description, "Internally-set ID"
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
      key :readOnly, true
      key :description, "Used to identify the app in secured API requests, normally as part of the HTTP header"
    end
    property :group_id do
      key :type, :string
      key :readOnly, true
      key :description, "Used to group apps"
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
    property :status_code do
      key :type, :integer
      key :description, "The HTTP status code"
    end
    property :messages do
      key :type, :array
      key :description, "The error messages, if any"
      items do
        key :type, :string
      end
    end
  end

end
