module Dropbox
  class WebhooksController < ActionController::Base
    def verify
      render :text => params[:challenge]
    end

    def receive
      Rails.logger.info "X-Dropbox-Signature: #{request.headers["X-Dropbox-Signature"]}"
      json = request.body.read
      Rails.logger.info json

      payload = JSON.load json
      payload["delta"]["users"].each do |uid|
        Tasks::BackgroundTask.new(Tasks::UpdateBulletins.new).perform(uid.to_s)
      end

      render :text => "ok\n"
    end
  end
end
