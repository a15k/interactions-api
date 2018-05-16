require 'rails_helper'

RSpec.describe Api::V0::FlagsController, type: :routing do
  describe '/api/flags routing', accept: :v1 do
    it 'routes to flags#create' do
      expect(post('/api/flags')).to route_to('api/v1/flags#create', format: :json)
    end

    it 'routes to flags#show' do
      expect(get('/api/flags/23')).to route_to('api/v1/flags#show', id: "23", format: :json)
    end

    it 'routes to flags#destroy' do
      expect(delete('/api/flags/23')).to route_to('api/v1/flags#destroy',  id: "23", format: :json)
    end
  end
end
