Chronos::Application.routes.draw do
  resources :albums
  resources :reactions
  resource :data, :controller => "data"
  
  resources :events do
    collection do
      post :upload
      get :preview
    end

  end
  resources :statuses
  resource :redirect
  match '/r/:id' => "redirects#show", :as => :short_link

  resources :streams do
    resources :links
    resources :reactions
    member do
     get :chart
    end
  end

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
    resource :lastfm, :controller => "basic_auth", :type => "lastfm"
    resource :muzzo, :controller => "basic_auth", :type => "muzzo"
  end

  match '/oauth/' => "sessions#new", :as => :login
  match '/oauth/process' => "sessions#create", :as => :oauth_process
  match '/oauth/destroy' => 'sessions#destroy', :as => :logout

  match '/auth/:provider/callback' => 'oauth#create', :as => :bind_account
  match "/dashboard" => "dashboard#index", :as => "dashboard"
  root :to => "dashboard#index"
end

