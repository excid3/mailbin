# 📬 Mailbin
Preview emails sent from ActionMailer in the browser.

Mailbin writes emails to `tmp/mailbin` for easy access and testing.

## 📦 Installation

Add Mailbin to your Gemfile:

```ruby
bundle add "mailbin"
```

Configure Rails to send emails to Mailbin:

```ruby
# config/environments/development.rb
config.action_mailer.delivery_method = :mailbin
config.action_mailer.perform_deliveries = true
```

Add the routes to view emails with MailBin:

```ruby
Rails.application.routes.draw do
  mount Mailbin::Engine => :mailbin if Rails.env.development?
end
```

## Usage

Open http://localhost:3000/mailbin to view your emails in development.

### Custom Storage Location

By default, emails are stored in `tmp/mailbin`. To override, set the `MAILBIN_LOCATION` environment variable.

The directory will be created automatically if it doesn't exist.

### Authentication (Optional)

For use in staging environemnts, you may protect mailbin with HTTP Basic Authentication:

```ruby
# config/initializers/mailbin.rb
Mailbin.configure do |config|
  config.authentication_username = ENV['MAILBIN_USERNAME']
  config.authentication_password = ENV['MAILBIN_PASSWORD']
  config.authentication_realm = "Email Viewer"  # Optional, defaults to "Mailbin"
end
```

Authentication is automatically enabled when both username and password are configured. Leave them blank in development to skip authentication.

## Contributing

If you have an issue you'd like to submit, please do so using the issue tracker in GitHub. In order for us to help you in the best way possible, please be as detailed as you can.

If you'd like to open a PR please make sure the following things pass:

```bash
bin/rails db:test:prepare
bin/rails test
bin/rubocop -A
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
