require_relative "lib/mailbin/version"

Gem::Specification.new do |spec|
  spec.name        = "mailbin"
  spec.version     = Mailbin::VERSION
  spec.authors     = [ "Chris Oliver" ]
  spec.email       = [ "excid3@gmail.com" ]
  spec.homepage    = "https://github.com"
  spec.summary     = "Mailbin collects emails from Rails ActionMailer in development for testing."
  spec.description = "Mailbin collects emails from Rails ActionMailer in development for testing."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.0"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "turbo-rails"
end
