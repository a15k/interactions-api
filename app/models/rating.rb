class Rating
  include RedisModel
  include PresentableModel

  # each CRUD operation updates the current state in Redis but also writes
  # an event to Kafka

  DATA_FIELDS = [:id, :app_id, :source_domain, :content_uid,
                 :variant_id, :user_uid, :type, :value,
                 :created_at]

  attr_reader *DATA_FIELDS

  validates :id, presence: true
  validates :app_id, presence: true
  validates :content_uid, presence: true
  validates :user_uid, presence: true
  validates :type, presence: true,
                   inclusion: { in: %w(thumbs five_star full_range) }
  validates :value, presence: true,
                    numericality: { greater_than_or_equal_to: -1.0,
                                    less_than_or_equal_to: 1.0 }
  validates :created_at, presence: true

  def self.create(app_api_id:, source_domain:, content_uid:,
                  variant_id:, user_uid:, type:, value:)
    new(id: SecureRandom.uuid,
        app_id: CachedApps.instance.find_by_api_id!(app_api_id).id,
        source_domain: source_domain,
        content_uid: content_uid,
        variant_id: variant_id,
        user_uid: user_uid,
        type: type,
        value: value,
        created_at: Time.current.utc).tap(&:save)
  end

  protected

  attr_writer *DATA_FIELDS

  def to_json
    as_json(only: DATA_FIELDS).to_json
  end

end
