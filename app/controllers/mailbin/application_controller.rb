class Mailbin::ApplicationController < ActionController::Base
  # Optional HTTP Basic Authentication
  # Configure via Mailbin.configure block in an initializer
  before_action :authenticate_if_configured

  private

  def authenticate_if_configured
    return unless Mailbin.authentication_enabled?

    authenticate_or_request_with_http_basic(Mailbin.authentication_realm) do |username, password|
      Mailbin.authenticate(username, password)
    end
  end
end
