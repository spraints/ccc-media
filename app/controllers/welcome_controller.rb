class WelcomeController < ApplicationController
  def index
    @users =
      if session[:db_uid].to_s == "10974355"
        DropboxUser.all
      else
        []
      end
  end

  def reset
    session.destroy
    redirect_to :action => :index
  end

  def callback
    if dbu = Tasks::Authenticate.new.perform(env["omniauth.auth"])
      session[:db_uid] = dbu.uid
    end
    redirect_to :action => :index
  end
end
