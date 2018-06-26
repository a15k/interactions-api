class Api::V0::PresentationsController < Api::V0::BaseController
  include Swagger::Blocks

  before_action :authenticate_api_id_and_domain

  swagger_path '/presentations' do
    operation :post do
      key :summary, 'Indicate that content was presented'
      key :description, 'Called when network content is presented to any end user'
      key :operationId, 'createPresentation'
      key :tags, [
        'Presentations'
      ]
      security do
        key :api_id, []
      end
      parameter do
        key :name, :presentation
        key :in, :body
        key :description, 'The presentation data'
        key :required, true
        schema do
          key :'$ref', :Presentation
        end
      end
      response 200 do
        key :description, 'Success.  Returns data associated with the content that was presented.'
        schema do
          key :'$ref', :PresentationResponse
        end
      end
      extend Api::V0::SwaggerResponses::AuthenticationErrorId
      extend Api::V0::SwaggerResponses::ForbiddenErrorId
      extend Api::V0::SwaggerResponses::ServerError
    end
  end

  def create
    binding, error = bind(params.require(:presentation), Api::V0::Bindings::Presentation)

    render(json: error, status: error.status_code) and return if error

    presentation = Presentation.create(app_api_id: api_id,
                                       source_domain: origin_host,
                                       content_uid: binding.content_uid,
                                       variant_id: binding.variant_id,
                                       user_uid: binding.user_uid,
                                       presented_at: binding.presented_at)

    if presentation.errors.any?
      render_errors(presentation.errors.messages)
    else
      flags = Flag.search(content_uid: presentation.content_uid,
                          variant_id: presentation.variant_id,
                          app_id: presentation.app_id,
                          user_uid: presentation.user_uid)
      ratings = Rating.search(content_uid: presentation.content_uid,
                              variant_id: presentation.variant_id,
                              app_id: presentation.app_id,
                              user_uid: presentation.user_uid)

      render status: :created,
             json: Api::V0::Bindings::PresentationResponse.new(
                     flags: flags,
                     ratings: ratings
                   ).to_json
    end
  end

end
