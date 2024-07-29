module MailDrop
  class DeliveryMethod
    attr_accessor :settings

    def initialize(options = {})
      self.settings = options
    end

    def deliver!(mail)
      FileUtils.mkdir_p(settings[:location])

      File.open(location_for(mail), "w") do |file|
        file.write(mail.encoded)
      end
    end

    private

    def location_for(mail)
      File.join(settings[:location], mail.message_id + ".eml")
    end
  end
end
