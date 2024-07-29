require "importmap-rails"
require "turbo-rails"

module Mailbin
  class Engine < ::Rails::Engine
    isolate_namespace Mailbin

    initializer "mailbin.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :mailbin,
          Mailbin::DeliveryMethod,
          location: Rails.root.join("tmp", "mailbin")
        )
      end
    end

    initializer "mailbin.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.precompile += %w[ mailbin_manifest ]
    end

    initializer "mailbin.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
    end
  end
end
