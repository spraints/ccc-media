class BulletinsController < ApplicationController
  def index
    @bulletins = DropboxFile.in_category("bulletin")
  end

  def show
    bulletin = DropboxFile.in_category("bulletin").current
    env[:download_directly] = bulletin
    redirect_to bulletin.public_url
  end
end
