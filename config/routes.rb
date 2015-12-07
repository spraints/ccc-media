Rails.application.routes.draw do
  # No home page
  root to: redirect("http://frankfortccc.com/")

  # List all available bulletins
  get "bulletins" => "bulletins#index"
  # Redirect to the current bulletin
  get "bulletins/current" => "bulletins#show"

  # A player for the most recent sermon
  get "sermons" => "sermons#show"
  # A player for an older sermon
  get "sermons/:year/:month/:day" => "sermons#show"


  # Dropbox's webhooks (https://www.dropbox.com/developers/reference/webhooks)
  get "dropbox/event" => "dropbox/webhooks#verify"
  post "dropbox/event" => "dropbox/webhooks#receive"

  # Admin page
  get "admin" => "admin#index"
  # Admin actions
  post "admin/scan" => "admin#scan"
  post "admin/urls" => "admin#update_urls"
  put "admin/users/:uid/:setting" => "admin/user_settings#create"
  delete "admin/users/:uid/:setting" => "admin/user_settings#destroy"

  # omniauth hook
  get "admin/login" => "admin_sessions#new"
  get "auth/:provider/callback" => "admin_sessions#create"
end
