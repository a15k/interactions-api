Rails.application.routes.draw do

  namespace :api do

    api_version(
      module: 'V0',
      path: { value: 'v0' },
      defaults: { format: :json },
      default: true
    ) do

      resources :apps, only: [:index, :create, :show, :update, :destroy]
      resources :flags, only: [:create, :show, :update, :destroy]
      resources :ratings, only: [:create, :show, :destroy]
      resources :presentations, only: [:create]
      resources :heartbeats, only: [:create]

    end

  end

  get 'api/docs/v0', to: 'docs/v0#index'

end
