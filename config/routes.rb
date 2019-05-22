Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :carts, only: [:create, :index] #added index as we need to show the cart -- User Story 2, Visitor Navigation

  resources :users, only:[:edit]

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout' #add logout to pass navigation - User Sotry 3, User Navigation

  get '/profile', to: 'users#show'

  get '/dashboard', to: 'merchants#show'

  get '/merchants', to: 'merchants#index' # a link to see all merchants ("/merchants") -- User Story 2, Visitor Navigation

  namespace :admin do
    resources :users, only: [:index]
    get '/dashboard', to: 'users#show'
  end
end
