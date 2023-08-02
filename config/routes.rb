Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  ActiveAdmin.routes(self)
  root to: "dsl_info#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stats
  get "/stats", to: "stats#query"
  resources :players
  resources :seasons
  resources :eras
  resources :every
  resources :dsl_info

  resources :charts 
  

  get "/comparison", to: "comparison#index"
  get "/about", to: "about#index"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
