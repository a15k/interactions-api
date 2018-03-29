require "kafka"
require "byebug"
require "avro_turf"
require 'avro_turf/messaging'

# no longer correct: curl -X POST -H "Accept: application/vnd.a15k.v1" http://localhost:3000/events

class Api::V1::FlagsController < ApplicationController
  include Swagger::Blocks

  swagger_path '/flags' do
    operation :post do
      key :summary, 'Flag some content'
      key :description, 'Flags a certain piece of content'
      key :operationId, 'createFlag'
      key :tags, [
        'Flags'
      ]
      parameter do
        key :name, :app_uid
        key :in, :body
        key :description, 'Unique ID of the app where the flag originated'
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :content_uid
        key :in, :body
        key :description, 'Unique ID of the content being flagged' # a15k ID or app's ID? either?
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :user_uid
        key :in, :body
        key :description, 'ID of the user doing the flag, unique in the scope of the reporting app'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'The created flag'
        schema do
          key :'$ref', :Flag
        end
      end
      response :default do
        key :description, 'unexpected error'
      end
    end
  end



  def create
    # See old V1::EventsController for some Kafka playing

    # 1. Parse and validate the incoming input
    # 2. Verify that the app UID is known
    # 3. Verify that the domain is whitelisted (if not already part of CORS check)
    # 4. Write the flag to redis (keep a list there)
    # 5. Write the flagging event to Kafka
  end



  # TODO add a delete endpoint; all flags should be returned in the presentation request
  # can also add an index here that returns all flags for a user/app/content combo.
  # Need delete so someone can unflag, duh.


  # Deletion API makes me realize that web API schemas and Kafka schemas are different
  # after all.  Kafka needs a "FlaggedContent" and "UnflaggedContent" schema


end
