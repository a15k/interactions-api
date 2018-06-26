module Api::V0::SwaggerModels::Rating
  include Swagger::Blocks
  include SwaggerBlocksExtensions

  swagger_schema :RatingNew do
    key :required, [:content_uid, :user_uid, :value]
  end

  swagger_schema :Rating do
    key :required, [:id, :content_uid, :user_uid, :value]
  end

  add_properties(:Rating) do
    property :id do
      key :type, :string
      key :format, 'uuid'
      key :readOnly, true
      key :description, "Internally-set UUID.  Used to retrieve and delete ratings, so treat it as somewhat secret."
    end
  end

  add_properties(:RatingNew, :Rating) do
    property :content_uid do
      key :type, :string
      key :format, 'uuid'
      key :description, "The a15k ID of the content being rated."
    end
    property :variant_id do
      key :type, :string
      key :description, "The variant ID, only needed for generative assessments"
    end
    property :user_uid do
      key :type, :string
      key :description, "The ID of the user doing the rating, unique in the " \
                        "scope of the reporting app"
    end
    property :type do
      key :type, :string
      key :description, "The type of rating"
      key :enum, [
        :thumbs, :five_star, :full_range
      ]
    end
    property :value do
      key :type, :number
      key :format, 'float'
      key :description, "The rating value.  Set value is based on the type, e.g. 1.0 is a thumbs up, -1.0 is a thumbs down."
      key :minimum, -1.0
      key :maximum, 1.0
    end
  end

end
