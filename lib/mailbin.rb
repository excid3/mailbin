require "mailbin/version"
require "mailbin/engine"

module Mailbin
  autoload :DeliveryMethod, "mailbin/delivery_method"
  autoload :InlinePreviewInterceptor, "mailbin/inline_preview_interceptor"

  mattr_accessor :importmap, default: Importmap::Map.new
  mattr_accessor :storage_location

  class << self
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
