Rails.application.routes.draw do

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  
  get '/profile', to: 'users#show'
  
  resources :items, only: [:index, :show]

  resources :users, only:[:new, :create, :show, :edit]

end
