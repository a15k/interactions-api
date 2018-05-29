class ApplicationController < ActionController::API

  protected

  def apps
    Thread.current[:apps] ||= CachedApps.new
  end

end
