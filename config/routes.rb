Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :users, only:[:edit]

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/profile/:id', to: 'users#show', as: :user

  get '/dashboard', to: 'merchants#show'
end
