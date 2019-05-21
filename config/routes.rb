Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/profile', to: 'users#show'

  get '/dashboard', to: 'merchants#show'

  resources :users, only: [:show, :edit]
end
