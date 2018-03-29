require "kafka"  # TODO clean up these requires
require "byebug"
require "avro_turf"
require 'avro_turf/messaging'

class Api::V1::FlagsController < ApplicationController
  include Swagger::Blocks

  swagger_path '/flags' do
    operation :post do
      key :summary, 'Flag some content'
      key :description, 'Adds a flag to some content for some user in some app.'
      key :operationId, 'createFlag'
      key :tags, [
        'Flags'
      ]
      parameter do
        key :name, :flag
        key :in, :body
        key :description, 'The flag data'
        key :required, true
        schema do
          key :'$ref', :Flag
        end
      end
      response 200 do
        key :description, 'Success.  Returns the created flag.'
        schema do
          key :'$ref', :Flag
        end
      end
      extend Api::V1::SwaggerResponses::AuthenticationError
    end
  end

  def create
    # 1. Parse and validate the incoming input
    # 2. Verify that the app UID is known
    # 3. Verify that the domain is whitelisted (if not already part of CORS check)
    # 4. Write the flag to redis (keep a list there)
    # 5. Write the flagging event to Kafka

    # Some Kafka playing:
    # # kafka = Kafka.new(["localhost:9092"], client_id: "interactions-api_#{SecureRandom.hex(3)}", logger: Rails.logger)
    # # kafka.deliver_message("Hello, World!", topic: "greetings")

    # avro = AvroTurf::Messaging.new(registry_url: "http://localhost:8081/", schemas_path: "app/schemas", namespace: "org.a15k")

    # # Encoding data has the side effect of registering the schema. This only
    # # happens the first time a schema is used with the instance of `AvroTurf`.
    # data = avro.encode({ "flag_type" => "typo", "app_id" => "blah" }, schema_name: "flagged_content")

    # kafka_producer.produce(data, topic: "greetings")
  end

  swagger_path '/flags/{id}' do
    operation :get do
      key :summary, 'Retrieve a flag'
      key :description, 'Retrieve a flag'
      key :operationId, 'getFlag'
      key :tags, [
        'Flags'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the flag to retrieve'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Success.  Returns the requested flag.'
        schema do
          key :'$ref', :Flag
        end
      end
      extend Api::V1::SwaggerResponses::NotFoundError
    end
  end

  def show
    # how to handle security? assume internally-generated UUIDs not guessable and dear lord don't make them
    # searchable
  end

  swagger_path '/flags/{id}' do
    operation :delete do
      key :summary, 'Delete a flag'
      key :description, 'Delete a flag'
      key :operationId, 'deleteFlag'
      key :tags, [
        'Flags'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of the flag to delete'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Success.  Returns the deleted flag.'
        schema do
          key :'$ref', :Flag
        end
      end
      extend Api::V1::SwaggerResponses::NotFoundError
    end
  end

  def destroy
    # how to handle security?
  end


end
