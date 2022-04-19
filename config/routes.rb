# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'
  # get 'about', to:'pages#about'
  resources :articles

  # RESTful routes for the users
  get 'signup', to: 'users#new'
  get '/user/:id/edit', to: 'users#edit', as: 'edit_user'
  get '/user/:id', to: 'users#show', as: 'user'
  patch '/user/:id', to: 'users#update'
  delete '/user/:id', to: 'users#destroy'
  resources :users, only: %i[index create]

  # Sessions routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Categories routes
  resources :categories, except: %i[destroy]
end
