Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'

  get '/profile', to: 'users#show'

end
