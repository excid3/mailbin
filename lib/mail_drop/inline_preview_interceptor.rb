module MailDrop
  class InlinePreviewInterceptor < ActionMailer::InlinePreviewInterceptor
    private
      # Convert to base64 unless it's already done
      def data_url(part)
        source = part.body.encoding == "base64" ? part.body.raw_source : strict_encode64(part.body.raw_source)
        "data:#{part.mime_type};base64,#{source}"
      end
  end
end
