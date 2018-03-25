Rails.application.routes.draw do

  # class Constraints
  #   def initialize(options)
  #     @version = options[:version]
  #     @default = options[:default]
  #   end

  #   def api_accept_header
  #     "application/vnd.a15k.#{@version.to_s}"
  #   end

  #   def matches?(req)
  #     !!(@default || req.headers['Accept'].try(:include?, api_accept_header))
  #   end
  # end

  # def api(version, options = {})
  #   api_namespace = (options.delete(:namespace) || 'api').to_s

  #   constraints = Constraints.new(version: version, default: options.delete(:default))

  #   scope(except: [:new, :edit],
  #         module: version,
  #         constraints: constraints,
  #         defaults: {format: 'json'}.merge(options)) do

  #     yield

  #     match '/*options', via: [:options], to: ->(*) { [200, {}, ['']] }
  #     match '/*other', via: [:all], to: ->(*) { [404, {"Content-Type" => 'application/json'}, ['']] }
  #   end
  # end

  # ###########################################

  # api :v1, default: true do
  #   resources :events, only: [:create]
  # end


  # You can leave default_version out, but if you do the first version used will become the default
  api vendor_string: "a15k", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        resources :content_flags, only: [:create, :show]
        # resources :events, only: [:create]
        # resources :authorizations
      end
    end

  end

  get 'api/docs/v1', to: 'docs/v1#index'
  # namespace :apidocs do
  #   get 'v1'
  # end
  # resources :apidocs, only: [:index]

end
