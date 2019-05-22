Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :carts, only: [:create]

  resources :users, only:[:edit]

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  patch 'profile/edit', to: 'users#patch'

  get '/dashboard', to: 'merchants#show'

  namespace :admin do
    resources :users, only: [:index]
    get '/dashboard', to: 'users#show'
  end
end
