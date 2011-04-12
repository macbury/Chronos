Chronos::Application.routes.draw do
  match '/r/:id' => "redirects#show", :as => :short_link
  
  resources :links
  resource :account, :controller => "account"
  resources :updates do
    member do
     get :chart
    end
  end
  resources :social_accounts
  resource :facebook_page
  resource :session
  
  scope "auth" do
    resource :lastfm, :controller => "lastfm"
  end
  
  match '/oauth/' => "sessions#new", :as => :login
  match '/oauth/process' => "sessions#create", :as => :oauth_process
  match '/oauth/destroy' => 'sessions#destroy', :as => :logout

  match '/auth/:provider/callback' => 'oauth#create', :as => :bind_account
  match "/dashboard" => "dashboard#index", :as => "dashboard"
  root :to => Rails.env == "production" ? redirect("http://rhmusic.pl") : "dashboard#index"
end
