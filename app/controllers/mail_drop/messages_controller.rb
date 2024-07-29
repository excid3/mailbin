module MailDrop
  class MessagesController < ApplicationController
    around_action :set_locale, only: [ :show ]

    helper_method :attachment_url, :part_query, :locale_query

    content_security_policy(false)

    def index
      @emails = MailDrop.all
    end

    def show
      @email = MailDrop.find(params[:id])
      @attachments = attachments_for(@email).reject { |filename, attachment| attachment.inline? }
      @inline_attachments = attachments_for(@email).select { |filename, attachment| attachment.inline? }

      if params[:part]
        part_type = Mime::Type.lookup(params[:part])

        if part = find_part(part_type)
          response.content_type = part_type
          render plain: part.respond_to?(:decoded) ? part.decoded : part
        else
          raise AbstractController::ActionNotFound, "Email part '#{part_type}' not found in #{@preview.name}##{@email_action}"
        end
      else
        @part = find_preferred_part(request.format, Mime[:html], Mime[:text])
        render layout: false, formats: [ :html ]
      end
    end

    def destroy
      MailDrop.destroy(params[:id])
      redirect_to root_path
    end

    private

    def find_preferred_part(*formats) # :doc:
      formats.each do |format|
        if part = @email.find_first_mime_type(format)
          return part
        end
      end

      if formats.any? { |f| @email.mime_type == f }
        @email
      end
    end

    def find_part(format) # :doc:
      if part = @email.find_first_mime_type(format)
        part
      elsif @email.mime_type == format
        @email
      end
    end

    def attachments_for(email)
      email.all_parts.to_a.select(&:attachment?).index_by do |attachment|
        attachment.respond_to?(:original_filename) ? attachment.original_filename : attachment.filename
      end
    end

    def attachment_url(attachment)
      "data:application/octet-stream;charset=utf-8;base64,#{Base64.encode64(attachment.body.to_s)}"
    end

    def part_query(mime_type)
      request.query_parameters.merge(part: mime_type).to_query
    end

    def locale_query(locale)
      request.query_parameters.merge(locale: locale).to_query
    end

    def set_locale(&block)
      I18n.with_locale(params[:locale] || I18n.default_locale, &block)
    end
  end
end
