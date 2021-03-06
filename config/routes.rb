Rails.application.routes.draw do

  get 'maps/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'


  root 'pages#index'
  get 'pages/index'

  resources :users
  resources :posts
  resources :maps, only: [:index]
  resources :reviews
  get '/map_request', to: 'maps#map', as: 'map_request'
  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#destroy'

end
