require_relative "lib/mail_drop/version"

Gem::Specification.new do |spec|
  spec.name        = "mail_drop"
  spec.version     = MailDrop::VERSION
  spec.authors     = [ "Chris Oliver" ]
  spec.email       = [ "excid3@gmail.com" ]
  spec.homepage    = "https://github.com"
  spec.summary     = "Summary of MailDrop."
  spec.description = "Description of MailDrop."
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
