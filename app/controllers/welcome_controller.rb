class WelcomeController < ApplicationController
  def index
    @users =
      if session[:db_uid].to_s == "10974355"
        DropboxUser.all
      else
        []
      end
    @bulletins = DropboxFile.in_category("bulletin")
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
