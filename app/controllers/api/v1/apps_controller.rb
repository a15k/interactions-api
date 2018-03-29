class Api::V1::AppsController < ApplicationController
  include Swagger::Blocks

  before_action :authenticate_admin_token

  swagger_path '/apps' do
    operation :post do
      key :summary, 'Create a new app'
      key :description, 'Create a new app with some values pre-populated; does not take initial values'
      key :operationId, 'createApp'
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      response 200 do
        key :description, 'Success.  Returns the created app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def create
    raise "NYI"
  end

  swagger_path '/apps/{id}/clone' do
    operation :post do
      key :summary, 'Clones an app'
      key :description, 'Create a new app that is a copy of an existing app'
      key :operationId, 'cloneApp'
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      response 200 do
        key :description, 'Success.  Returns the cloned app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def clone
    raise "NYI"
  end

  swagger_path '/apps/{id}' do
    operation :get do
      key :summary, 'Get a specific app'
      key :description, 'Returns all information about a specific app'
      key :operationId, 'getApp'
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the app'
        key :required, true
        key :type, :string
      end
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      response 200 do
        key :description, 'Success.  Returns the requested app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def show
    raise "NYI"
  end

  swagger_path '/apps' do
    operation :put do
      key :summary, 'Update an app'
      key :description, 'Update an app with the provided values'
      key :operationId, 'createApp'
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      parameter do
        key :name, :app
        key :in, :body
        key :description, 'The app data'
        schema do
          key :'$ref', :App
        end
      end
      response 200 do
        key :description, 'Success.  Returns the updated app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def update
    raise "NYI"
  end

  swagger_path '/apps/{id}' do
    operation :delete do
      key :summary, 'Delete an app'
      key :description, 'Delete the specified app'
      key :operationId, 'deleteApp'
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the app to delete'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Success.  Returns the deleted app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def destroy
    raise "NYI"
  end

end
