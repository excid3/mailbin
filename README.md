# 📬 Mailbin
Preview emails sent from ActionMailer in the browser.

Mailbin writes emails to `tmp/mailbin` for easy access and testing.

## 📦 Installation

Add Mailbin to your Gemfile:

```ruby
bundle add "mailbin"
```

Configure Rails to send emails to MailBin:

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
