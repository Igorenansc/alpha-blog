Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'
  # get 'about', to:'pages#about'
  resources :articles

  get 'signup', to: 'users#new'
  get '/user/:id/edit', to: 'users#edit', as: 'edit_user'
  get '/user/:id', to: 'users#show', as: 'user'
  resources :users, except: %i[new edit show]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
