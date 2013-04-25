EcosynthetixApp::Application.routes.draw do  

  resources :alerts

  # Users
  devise_for :users, :path_prefix => 'auth', :controllers => { :passwords => 'users/passwords', :sessions => 'users/sessions' }
  devise_scope :user do
    get '/login' => 'users/sessions#new'
  end
  match '/users/me' => 'users#me'
  resources :users
  
  # Facilities
  resources :facilities
  
  # Lab Methods
  resources :lab_methods
  
  # Products
  resources :products

  # Qualities / Quality Control
  match 'quality-assurance/modal' => 'quality#modal'
  resources :qualities, :path => 'quality-assurance', :controller => 'quality'
  
  # Quality History
  resources :quality_histories, :path => 'quality-history', :controller => 'quality_histories'
  
  # Lots
  match 'lot/certificate_review' => 'lot#certificate_review'
  match 'lot/:action', :controller => 'lot'
  match 'lot/:action/:id', :controller => 'lot'

  # Other
  match 'dashboard' => 'main#dashboard'
  match 'reporting' => 'main#reporting'
  match 'settings' => 'main#settings'
  match 'search' => 'main#search'
  match 'search.xlsx' => 'main#search.xlsx'
  match 'options' => 'main#options'
  
  # Root
  root :to => 'main#dashboard' 
  
end
