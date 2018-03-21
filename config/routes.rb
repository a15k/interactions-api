Rails.application.routes.draw do

  class Constraints
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
    end

    def api_accept_header
      "application/vnd.a15k.#{@version.to_s}"
    end

    def matches?(req)
      !!(@default || req.headers['Accept'].try(:include?, api_accept_header))
    end
  end

  def api(version, options = {})
    api_namespace = (options.delete(:namespace) || 'api').to_s

    constraints = Constraints.new(version: version, default: options.delete(:default))

    scope(except: [:new, :edit],
          module: version,
          constraints: constraints,
          defaults: {format: 'json'}.merge(options)) do

      yield

      match '/*options', via: [:options], to: ->(*) { [200, {}, ['']] }
      match '/*other', via: [:all], to: ->(*) { [404, {"Content-Type" => 'application/json'}, ['']] }
    end
  end

  ###########################################

  api :v1, default: true do
    resources :events, only: [:create]
  end


end
