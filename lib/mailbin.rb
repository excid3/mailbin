require "mailbin/version"
require "mailbin/engine"

module Mailbin
  autoload :DeliveryMethod, "mailbin/delivery_method"
  autoload :InlinePreviewInterceptor, "mailbin/inline_preview_interceptor"

  mattr_accessor :importmap, default: Importmap::Map.new

  # Authentication configuration
  mattr_accessor :authentication_username
  mattr_accessor :authentication_password
  mattr_accessor :authentication_realm, default: "Mailbin"

  class << self
    # Configure Mailbin (call this in an initializer)
    def configure
      yield self if block_given?
    end

    # Check if authentication is enabled
    def authentication_enabled?
      authentication_username.present? && authentication_password.present?
    end

    # Authenticate credentials
    def authenticate(username, password)
      # Return false if authentication not configured
      return false unless authentication_enabled?

      # Constant-time comparison to prevent timing attacks
      ActiveSupport::SecurityUtils.secure_compare(username, authentication_username.to_s) &&
        ActiveSupport::SecurityUtils.secure_compare(password, authentication_password.to_s)
    end

    def all
      Dir.glob("*.eml", base: settings[:location]).map do |message_id|
        find(message_id)
      end.sort_by(&:date).reverse!
    end

    def find(message_id)
      InlinePreviewInterceptor.previewing_email Mail.read(location_for(message_id))
    end

    def destroy(message_id)
      File.delete location_for(message_id)
    end

    def destroy_all
      Dir.glob("*.eml", base: settings[:location]).map do |message_id|
        destroy(message_id)
      end
    end

    def location_for(message_id)
      message_id += ".eml" unless message_id.end_with?(".eml")
      File.join(settings[:location], message_id)
    end

    def settings
      ActionMailer::Base.mailbin_settings
    end
  end
end
