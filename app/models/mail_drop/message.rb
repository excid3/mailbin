class MailDrop::Message
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id
  attribute :created_at, :datetime

  def self.all
    messages = Dir.glob("#{ActionMailer::Base.mail_drop_settings.fetch(:location)}/*.eml").map do |path|
      new(id: path, created_at: File.mtime(path))
    end
    messages.sort_by(&:created_at).reverse
  end

  def self.find(id)
    new(id: id)
  end

  def mail
    @mail ||= Mail.read(id)
  end
end
