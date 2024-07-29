require "importmap-rails"
require "turbo-rails"

module MailDrop
  class Engine < ::Rails::Engine
    isolate_namespace MailDrop

    initializer "mail_drop.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :mail_drop,
          MailDrop::DeliveryMethod,
          location: Rails.root.join("tmp", "mail_drop")
        )
      end
    end
  end
end
