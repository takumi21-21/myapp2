Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'pages#index'
  get 'pages/index'

  resources :users
  resources :posts

  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#destroy'
end
