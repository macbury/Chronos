Chronos::Application.routes.draw do
  resources :social_accounts
  
  resource :facebook_page
  resource :session
  match '/oauth/' => "sessions#new", :as => :login
  match '/oauth/process' => "sessions#create", :as => :oauth_process
  match '/oauth/destroy' => 'sessions#destroy', :as => :logout
  
  match '/auth/:provider/callback' => 'oauth#create', :as => :bind_account
  
  match '/api_test' => "home#api"
  
  root :to => "social_accounts#index"
end
