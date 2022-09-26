Rails.application.routes.draw do
  root to: "stats#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stats
  get "/stats", to: "stats#query"
  resources :players
  # Defines the root path route ("/")
  # root "articles#index"
end
