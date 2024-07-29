class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = "Hi"
    attachments.inline["logo.png"] = File.read Rails.root.join("app/assets/images/logo.png")
    attachments["file.zip"] = File.read File.join(__dir__, "file.zip")

    mail to: "to@example.org"
  end
end
