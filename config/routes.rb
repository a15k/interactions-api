Rails.application.routes.draw do

  namespace :api do

    api_version(
      module: 'V1',
      header: { name: 'Accept', value: 'application/vnd.interactions.a15k.org; version=1' },
      defaults: { format: :json },
      default: true
    ) do

      resources :apps, only: [:create, :show, :update, :destroy] do
        post :clone, on: :member
      end
      resources :flags, only: [:create, :show, :destroy]
      resources :ratings, only: [:create, :show, :destroy]
      resources :presentations, only: [:create]
      resources :heartbeats, only: [:create]


    end

  end

  get 'api/docs/v1', to: 'docs/v1#index'

end
