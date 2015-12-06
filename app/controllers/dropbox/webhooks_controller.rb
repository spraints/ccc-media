module Dropbox
  class WebhooksController < ActionController::Base
    def verify
      render :text => params[:challenge]
    end

    def receive
      Rails.logger.info "X-Dropbox-Signature: #{request.headers["X-Dropbox-Signature"]}"
      Rails.logger.info request.body.read
      # todo - look for new bulletins
      render :text => "ok\n"
    end
  end
end
