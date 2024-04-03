Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  ActiveAdmin.routes(self)
  root to: "dsl_info#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/stats/all", to: "stats#all"
  get "/stats/male", to: "stats#male"
  get "/stats/female", to: "stats#female"
  get '/dsl_info/adjusted', to:'dsl_info#adjusted'

  resources :stats
  resources :players
  resources :seasons
  resources :eras
  resources :every
  resources :dsl_info
  resources :years
  resources :teams do
    collection do
      get 'all'
    end
    collection do
      get 'coach'
    end
  end
  get 'teams/all', to: 'teams#all', as: :teams_all
  get 'teams/coach', to: 'teams#coach', as: :teams_coach


  resources :charts 
  
  

  get "/comparison", to: "comparison#index"
  get "/about", to: "about#index"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
