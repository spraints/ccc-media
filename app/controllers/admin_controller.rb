class AdminController < ApplicationController
  before_action :ensure_admin

  def index
    @users = DropboxUser.all
    @files = DropboxFile.for_list
  end

  def scan
    maybe_background(Tasks::UpdateBulletins.new).perform(params[:uid].to_s)
    redirect_to :action => :index
  end

  def update_urls
    maybe_background(Tasks::UpdatePublicUrls.new).perform(params[:uid].to_s)
    redirect_to :action => :index
  end

  def maybe_background(task)
    if params[:background]
      Tasks::BackgroundTask.new(task)
    else
      task
    end
  end
end
