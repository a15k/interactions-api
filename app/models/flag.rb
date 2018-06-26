require "kafka"  # TODO clean up these requires
require "avro_turf"
require 'avro_turf/messaging'

class Flag
  include RedisModel
  include PresentableModel

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  DATA_FIELDS = [:id, :app_id, :source_domain, :content_uid,
                 :variant_id, :user_uid, :type, :explanation,
                 :created_at]

  attr_reader *DATA_FIELDS

  validates :id, presence: true
  validates :app_id, presence: true
  validates :content_uid, presence: true
  validates :user_uid, presence: true
  validates :type, presence: true,
                   inclusion: { in: %w(unspecified typo copyright_violation incorrect offensive) }
  validates :created_at, presence: true

  def self.create(app_api_id:, source_domain:, content_uid:,
                  variant_id:, user_uid:, type:, explanation:)
    Flag.new(id: SecureRandom.uuid,
             app_id: CachedApps.instance.find_by_api_id!(app_api_id).id,
             source_domain: source_domain,
             content_uid: content_uid,
             variant_id: variant_id,
             user_uid: user_uid,
             type: type,
             explanation: explanation,
             created_at: Time.current.utc).tap(&:save)
  end

  def update(type: nil, explanation: nil)
    # Can update only one or neither
    self.type = type if type.present?
    self.explanation = explanation if explanation.present?
    save
  end

  protected

  attr_writer *DATA_FIELDS

  def to_json
    as_json(only: DATA_FIELDS).to_json
  end

end
