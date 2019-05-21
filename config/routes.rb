Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/profile/:id', to: 'users#show', as: :user

  resources :items, only: [:index, :show]

  resources :users, only:[:new, :create, :edit]

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/dashboard', to: 'merchants#show'

end
