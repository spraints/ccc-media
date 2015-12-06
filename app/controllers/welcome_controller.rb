class WelcomeController < ApplicationController
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
