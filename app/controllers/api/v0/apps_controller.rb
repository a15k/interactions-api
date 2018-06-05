class Api::V0::AppsController < Api::V0::BaseController
  include Swagger::Blocks

  before_action :authenticate_admin_api_token
  before_action :get_app, only: [:show, :update, :destroy]

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
      extend Api::V0::SwaggerResponses::AuthenticationError
      extend Api::V0::SwaggerResponses::ForbiddenError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def create
    app = App.create(group_id: params[:group_id])
    render json: to_json(app), status: :created
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
      extend Api::V0::SwaggerResponses::AuthenticationError
      extend Api::V0::SwaggerResponses::ForbiddenError
      extend Api::V0::SwaggerResponses::NotFoundError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def show
    render json: to_json(@app), status: :ok
  end

  swagger_path '/apps' do
    operation :get do
      key :summary, 'Get all apps matching a query'
      key :description, 'Get all apps matching a query.'
      key :operationId, 'getApps'
      parameter do
        key :name, :group_id
        key :in, :query
        key :description, 'ID under which apps are grouped (e.g. the UUID) of the app owner.' \
                          'If not provided, returns all apps.'
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
        schema do
          key :type, :array
          items do
            key :'$ref', :App
          end
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationError
      extend Api::V0::SwaggerResponses::ForbiddenError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def index
    apps = App.search(group_id: params[:group_id])
    render json: apps, status: :ok
  end

  swagger_path '/apps/{id}' do
    operation :put do
      key :summary, 'Update an app'
      key :description, 'Update an app with the provided values.'
      key :operationId, 'updateApp'
      security do
        key :api_token, []
      end
      key :tags, [
        'Apps'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the app'
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :app
        key :in, :body
        key :description, 'The app data'
        schema do
          key :'$ref', :AppUpdate
        end
      end
      response 200 do
        key :description, 'Success.  Returns the updated app.'
        schema do
          key :'$ref', :App
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationError
      extend Api::V0::SwaggerResponses::ForbiddenError
      extend Api::V0::SwaggerResponses::NotFoundError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def update
    binding, error = bind(params[:app], Api::V0::Bindings::AppUpdate)

    render(json: error, status: error.status_code) and return if error

    @app.update(name: binding.name, whitelisted_domains: binding.whitelisted_domains)

    render json: to_json(@app), status: :ok
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
      extend Api::V0::SwaggerResponses::AuthenticationError
      extend Api::V0::SwaggerResponses::ForbiddenError
      extend Api::V0::SwaggerResponses::NotFoundError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def destroy
    @app.destroy
    render json: to_json(@app), status: :ok
  end

  protected

  def get_app
    @app = App.find(params[:id])
    return head(:not_found) if @app.nil?
  end

  def to_json(app)
    Api::V0::Bindings::App.new(
      id: app.id,
      name: app.name,
      api_id: app.api_id,
      api_token: app.api_token,
      whitelisted_domains: app.whitelisted_domains
    ).to_json
  end

end
