class App
  include ActiveModel::Serializers::JSON
  include RedisConnection

  attr_reader :id, :group_id, :api_id, :api_token, :name, :whitelisted_domains, :created_at

  def self.create(group_id: nil, api_id: nil, api_token: nil, name: nil, whitelisted_domains: [])
    app = App.new(id: SecureRandom.uuid,
                  group_id: group_id,
                  api_id: api_id || SecureRandom.base64(8),
                  api_token: api_token || SecureRandom.base64(20),
                  name: name,
                  whitelisted_domains: whitelisted_domains,
                  created_at: Time.current.utc)

    app.save
    app
  end

  def save
    redis.multi do
      redis.set("apps:id:#{id}", to_json)
      redis.sadd("apps:all", id)
      redis.sadd("apps:group:#{group_id}", id) if group_id.present?
    end
    true
  end

  def self.search(group_id: nil)
    app_id_set_key = group_id.nil? ? "apps:all" : "apps:group:#{group_id}"
    app_ids = redis.smembers(app_id_set_key)
    [find(app_ids)].flatten.compact
  end

  def self.find(ids)
    ids = [ids].flatten.compact

    return nil if ids.empty?

    apps_data = redis.mget(ids.map{|id| "apps:id:#{id}"})
    apps = apps_data.map do |app_data|
      app_data.nil? ? nil : App.new.from_json(app_data)
    end

    ids.count == 1 ? apps.first : apps
  end

  def update(name:, whitelisted_domains:)
    app = App.find(id)

    app.name = name
    app.whitelisted_domains = whitelisted_domains

    app.save
  end

  def destroy
    redis.multi do
      redis.del("apps:id:#{id}")
      redis.srem("apps:all", id)
      redis.srem("apps:group:#{group_id}", id) if group_id.present?
    end
  end

  def attributes
    { 'id' => nil,
      'group_id' => nil,
      'api_id' => nil,
      'api_token' => nil,
      'name' => nil,
      'whitelisted_domains' => nil,
      'created_at' => nil }
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  protected

  attr_writer :id, :group_id, :api_id, :api_token, :name, :whitelisted_domains, :created_at

  def initialize(id: nil, group_id: nil, api_id: nil, api_token: nil, name: nil,
                 whitelisted_domains: [], created_at: nil)
    @id = id
    @group_id = group_id
    @api_id = api_id
    @api_token = api_token
    @name = name
    @whitelisted_domains = whitelisted_domains.map(&:clone)
    @created_at = created_at
  end

end
