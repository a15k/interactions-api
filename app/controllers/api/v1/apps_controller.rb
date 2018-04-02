class Api::V1::AppsController < ApplicationController
  include Swagger::Blocks

  before_action :authenticate_admin_token

  swagger_path '/apps' do
    operation :post do
      key :summary, 'Create a new app'
      key :description, 'Create a new app with some values pre-populated; does not take initial values'
      key :operationId, 'createApp'
      parameter do
        key :name, :group_id
        key :in, :query
        key :description, 'ID under which the new app should be grouped (e.g. the UUID) ' \
                          'of the app owner.  Can be used to later retrieve all apps in ' \
                          'the same group at once.'
        key :required, false
        key :type, :string
      end
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
    app = App.create(api_id: SecureRandom.base64(8),
                     api_token: SecureRandom.base64(20),
                     group_id: params[:group_id])
    render json: to_json(app), status: :created
  end

  def to_json(app)
    Api::V1::Bindings::App.new(
      id: app.id,
      name: app.name,
      api_id: app.api_id,
      api_token: app.api_token,
      whitelisted_domains: app.whitelisted_domains.map(&:value)
    ).to_json
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
    app = App[params[:id]]
    return head(:not_found) if app.nil?
    render json: to_json(app), status: :success
  end

  swagger_path '/apps' do
    operation :get do
      key :summary, 'Get all apps matching a query'
      key :description, 'Get all apps matching a query.'
      key :operationId, 'getApps'
      parameter do
        key :name, :group_id
        key :in, :query
        key :description, 'ID under which apps are grouped (e.g. the UUID) of the app owner.'
        key :required, false
        key :type, :string
      end
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      response 200 do
        key :description, 'Success.  Returns the requested apps.'
        schema type: :array do
          key :'$ref', :App
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
      extend Api::V1::SwaggerResponses::ForbiddenError
      extend Api::V1::SwaggerResponses::ServerError
    end
  end

  def index
    raise "NYI"
  end

  swagger_path '/apps' do
    operation :put do
      key :summary, 'Update an app'
      key :description, 'Update an app with the provided values.'
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
