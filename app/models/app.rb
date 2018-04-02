class App < Ohm::Model
  attribute :name
  attribute :api_id
  attribute :api_token
  attribute :group_id
  set :whitelisted_domains, :Domain

  index :api_token
  index :api_id
  index :group_id
end
