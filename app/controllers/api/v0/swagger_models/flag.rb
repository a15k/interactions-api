module Api::V0::SwaggerModels::Flag
  include Swagger::Blocks
  include SwaggerBlocksExtensions

  swagger_schema :FlagNew do
    key :required, [:content_uid, :user_uid, :type]
  end

  swagger_schema :Flag do
    key :required, [:id, :content_uid, :user_uid, :type]
  end

  swagger_schema :FlagUpdate

  add_properties(:Flag) do
    property :id do
      key :type, :string
      key :format, 'uuid'
      key :readOnly, true
      key :description, "Internally-set UUID.  Used to retrieve and delete flags, so treat it as somewhat secret."
    end
  end

  add_properties(:FlagNew, :Flag) do
    property :content_uid do
      key :type, :string
      key :format, 'uuid'
      key :description, "The a15k ID of the content being flagged."
    end
    property :variant_id do
      key :type, :string
      key :description, "The variant ID, only needed for generative assessments"
    end
    property :user_uid do
      key :type, :string
      key :description, "The ID of the user doing the flagging, unique in the " \
                        "scope of the reporting app"
    end
  end

  add_properties(:FlagNew, :Flag, :FlagUpdate) do
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

end
