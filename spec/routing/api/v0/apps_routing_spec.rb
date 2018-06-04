require 'rails_helper'

RSpec.describe Api::V0::AppsController, type: :routing do
  describe '/api/apps routing', api: :v0 do
    it 'routes to apps#create' do
      expect(post('/api/apps')).to route_to('api/v0/apps#create', format: :json)
    end

    it 'routes to apps#show' do
      expect(get('/api/apps/23')).to route_to('api/v0/apps#show', id: "23", format: :json)
    end

    it 'routes to apps#update' do
      expect(put('/api/apps/23')).to route_to('api/v0/apps#update',  id: "23", format: :json)
    end

    it 'routes to apps#destroy' do
      expect(delete('/api/apps/23')).to route_to('api/v0/apps#destroy',  id: "23", format: :json)
    end
  end
end
