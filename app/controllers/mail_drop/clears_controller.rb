module MailDrop
  class ClearsController < ApplicationController
    def destroy
      MailDrop.destroy_all
      redirect_to root_path
    end
  end
end
