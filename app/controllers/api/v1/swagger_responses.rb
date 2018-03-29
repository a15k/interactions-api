module Api::V1::SwaggerResponses
  module AuthenticationError
    def self.extended(base)
      base.response 401 do
        key :description, 'Not authorized'
      end
    end
  end

  module ForbiddenError
    def self.extended(base)
      base.response 403 do
        key :description, 'Forbidden'
      end
    end
  end

  module ServerError
    def self.extended(base)
      base.response 500 do
        key :description, 'Server error.'
        schema do
          key :'$ref', :Error
        end
      end
    end
  end
end
