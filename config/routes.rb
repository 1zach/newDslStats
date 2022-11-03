Rails.application.routes.draw do
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
  
  # Defines the root path route ("/")
  # root "articles#index"
end
