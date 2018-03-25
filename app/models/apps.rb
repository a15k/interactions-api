require 'celluloid/current'

class Apps
  include Celluloid
  attr_reader :timer

  # TODO consider using apps_client.last_offset_for to figure out how much to read
  # also consider scheduling next read, unlikely that can't read all

  def initialize
    @data = {}
    @starting_offset = 0
    @timer = every(60) do
      messages = apps_client.fetch_messages(
        topic: "apps",
        partition: 0,
        offset: @starting_offset,
      )

      messages.each do |message|
        puts message.offset, message.key, message.value

        # Set the next offset that should be read to be the subsequent
        # offset.
        @starting_offset = message.offset + 1
      end

    end
  end

  protected

  def apps_client
    @apps_consumer ||= KafkaHelpers.new_client(name: "apps")
  end
end
