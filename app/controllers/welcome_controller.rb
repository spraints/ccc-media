class WelcomeController < ApplicationController
  def reset
    session.destroy
    redirect_to :action => :index
  end

  def callback
#    session[:callback_keys] = env.keys
    session[:params] = params.to_hash
    session[:omniauth] = {
#      "omniauth.strategy" => env["omniauth.strategy"].inspect,
#      "omniauth.origin"   => env["omniauth.origin"].inspect,
#      "omniauth.params"   => env["omniauth.params"].inspect,
      "omniauth.auth"     => env["omniauth.auth"].to_hash,
    }
    redirect_to :action => :index
  end
end
