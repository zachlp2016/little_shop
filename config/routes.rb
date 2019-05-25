Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]

  get '/carts', to: 'carts#show'
  post '/carts', to: 'carts#add'
  delete '/carts', to: 'carts#clear'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout' #add logout to pass navigation - User Sotry 3, User Navigation

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'
  get '/profile/orders', to: 'orders#index'
  get '/profile/orders/:id', to: 'orders#show', as: :profile_order


  get '/dashboard', to: 'merchants#show'
  get '/merchants', to: 'merchants#index' # a link to see all merchants ("/merchants") -- User Story 2, Visitor Navigation

  namespace :admin do
    resources :users, only: [:index, :show]
    get '/dashboard', to: 'users#show'
  end
end
