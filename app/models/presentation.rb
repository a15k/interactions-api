class Presentation
  include ActiveModel::Validations

  # We have no need to save presentations to Redis (as they aren't retrieved) -
  # they will just be saved to Kafka

  DATA_FIELDS = [:id, :app_id, :source_domain, :content_uid,
                 :variant_id, :user_uid, :presented_at, :created_at]

  attr_reader *DATA_FIELDS

  validates :id, presence: true
  validates :app_id, presence: true
  validates :source_domain, presence: true
  validates :content_uid, presence: true
  validates :user_uid, presence: true
  validates :presented_at, presence: true
  validates :created_at, presence: true

  def self.create(app_api_id:, source_domain:, content_uid:,
                  variant_id:, user_uid:, presented_at:)
    Presentation.new(id: SecureRandom.uuid,
                     app_id: CachedApps.instance.find_by_api_id!(app_api_id).id,
                     source_domain: source_domain,
                     content_uid: content_uid,
                     variant_id: variant_id,
                     user_uid: user_uid,
                     presented_at: presented_at,
                     created_at: Time.current.utc).tap do |presentation|
      validate

      # TODO "save" to Kafka
    end
  end

  def attributes
    instance_values
  end

  protected

  attr_writer *DATA_FIELDS

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def initialize(data = {})
    self.attributes = data
  end

end
