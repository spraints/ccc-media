class AdminSessionsController < ApplicationController
  def create
    if dbu = Tasks::Authenticate.new.perform(env["omniauth.auth"])
      session[:db_email] = dbu.email
    end
    redirect_to admin_path
  end
end
