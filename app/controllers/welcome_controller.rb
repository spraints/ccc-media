class WelcomeController < ApplicationController
  def index
    @users =
      if admin?
        DropboxUser.all
      else
        []
      end
    @bulletins =
      if admin?
        DropboxFile.in_category("bulletin")
      else
        []
      end
  end

  def reset
    session.destroy
    redirect_to :action => :index
  end

  def auth_callback
    if dbu = Tasks::Authenticate.new.perform(env["omniauth.auth"])
      session[:db_uid] = dbu.uid
    end
    redirect_to :action => :index
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
