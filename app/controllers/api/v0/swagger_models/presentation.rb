module Api::V0::SwaggerModels::Presentation
  include Swagger::Blocks
  include SwaggerBlocksExtensions

  swagger_schema :Presentation do
    key :required, [:content_uid, :user_uid, :presented_at]
    property :content_uid do
      key :type, :string
      key :format, 'uuid'
      key :description, "The a15k ID of the content being presented."
    end
    property :variant_id do
      key :type, :string
      key :description, "The variant ID, only needed for generative assessments"
    end
    property :user_uid do
      key :type, :string
      key :description, "The ID of the user being presented with the content, unique in the " \
                        "scope of the reporting app"
    end
    property :presented_at do
      key :type, :string
      key :format, 'date-time'
      key :description, "The date time when the content was presented to the end user, in " \
                        "ISO 8601 notation (https://tools.ietf.org/html/rfc3339#section-5.6), " \
                        "e.g. 2017-07-21T17:32:28Z"
    end
  end

  swagger_schema :PresentationResponse do
    property :flags do
      key :type, :array
      key :description, "The flags associated with the presented assessment's a15k ID, " \
                        "the variant ID, the app ID, and the user ID"
      items do
        key :'$ref', :Flag
      end
    end
    property :ratings do
      key :type, :array
      key :description, "The ratings associated with the presented assessment's a15k ID, " \
                        "the variant ID, the app ID, and the user ID"
      items do
        key :'$ref', :Rating
      end
    end
  end

end
