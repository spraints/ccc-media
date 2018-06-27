class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
    session[:db_email].to_s == ENV["ADMIN_EMAIL"]
  end

  def ensure_admin
    redirect_to admin_login_path unless admin?
  end
end
