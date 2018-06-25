class Api::V0::RatingsController < Api::V0::BaseController
  include Swagger::Blocks

  before_action :authenticate_api_id_and_domain
  before_action :get_rating, only: [:show, :update, :destroy]

  swagger_path '/ratings' do
    operation :post do
      key :summary, 'Rate some content'
      key :description, 'Rates some content for some user in some app.  New ratings replace old ratings.'
      key :operationId, 'createRating'
      key :tags, [
        'Ratings'
      ]
      security do
        key :api_id, []
      end
      parameter do
        key :name, :rating
        key :in, :body
        key :description, 'The rating data'
        key :required, true
        schema do
          key :'$ref', :RatingNew
        end
      end
      response 200 do
        key :description, 'Success.  Returns the created rating.'
        schema do
          key :'$ref', :Rating
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationErrorId
      extend Api::V0::SwaggerResponses::ForbiddenErrorId
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def create
    binding, error = bind(params.require(:rating), Api::V0::Bindings::RatingNew)

    render(json: error, status: error.status_code) and return if error

    rating = Rating.create(app_api_id: api_id,
                           source_domain: origin_host,
                           content_uid: binding.content_uid,
                           variant_id: binding.variant_id,
                           user_uid: binding.user_uid,
                           value: binding.value)

    if rating.errors.any?
      render_errors(rating.errors.messages)
    else
      render json: to_json(rating), status: :created
    end
  end

  swagger_path '/ratings/{id}' do
    operation :get do
      key :summary, 'Retrieve a rating'
      key :description, 'Retrieve a rating.  Anyone with the rating ID (very hard to guess) can retrieve it.'
      key :operationId, 'getRating'
      key :tags, [
        'Ratings'
      ]
      security do
        key :api_id, []
      end
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the rating to retrieve'
        key :required, true
        key :type, :string
        key :format, 'uuid'
      end
      response 200 do
        key :description, 'Success.  Returns the requested rating.'
        schema do
          key :'$ref', :Rating
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationErrorId
      extend Api::V0::SwaggerResponses::ForbiddenErrorId
      extend Api::V0::SwaggerResponses::NotFoundError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def show
    render json: to_json(@rating), status: :ok
  end

  swagger_path '/ratings/{id}' do
    operation :delete do
      key :summary, 'Delete a rating'
      key :description, 'Delete a rating.  Anyone with the rating ID (very hard to guess) can delete it.'
      key :operationId, 'deleteRating'
      key :tags, [
        'Ratings'
      ]
      security do
        key :api_id, []
      end
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the rating to delete'
        key :required, true
        key :type, :string
        key :format, 'uuid'
      end
      response 200 do
        key :description, 'Success.  Returns the deleted rating.'
        schema do
          key :'$ref', :Flag
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationErrorId
      extend Api::V0::SwaggerResponses::ForbiddenErrorId
      extend Api::V0::SwaggerResponses::NotFoundError
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def destroy
    @rating.destroy
    render json: to_json(@rating), status: :ok
  end

  protected

  def get_rating
    @rating = Rating.find(params[:id])
    return head(:not_found) if @rating.nil?
  end

  def to_json(rating)
    Api::V0::Bindings::Rating.new(
      id: rating.id,
      content_uid: rating.content_uid,
      variant_id: rating.variant_id,
      user_uid: rating.user_uid,
      value: rating.value
    ).to_json
  end

end
