module Mailbin
  class ClearsController < ApplicationController
    def destroy
      Mailbin.destroy_all
      redirect_to root_path
    end
  end
end
