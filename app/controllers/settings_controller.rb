class SettingsController < ApplicationController
  before_action :ensure_admin

  def create
    user = DropboxUser.for_uid!(params[:uid].to_s)
    if params[:setting] == "sync_enabled"
      user.sync_enabled = true
      user.save!
    end
    redirect_to "/"
  end

  def destroy
    user = DropboxUser.for_uid!(params[:uid].to_s)
    if params[:setting] == "sync_enabled"
      user.sync_enabled = false
      user.save!
    end
    redirect_to "/"
  end
end
