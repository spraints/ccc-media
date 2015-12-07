class BulletinsController < ApplicationController
  def index
    @bulletins = DropboxFile.in_category("bulletin")
  end

  def show
    bulletin = DropboxFile.in_category("bulletin").current
    redirect_to bulletin.public_url
  end
end
