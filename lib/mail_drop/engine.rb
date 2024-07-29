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

    initializer "mail_drop.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.precompile += %w[ mail_drop_manifest ]
    end

    initializer "mail_drop.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
    end
  end
end
