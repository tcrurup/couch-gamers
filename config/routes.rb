Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#new'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#delete'
  


  resources :users, only: [:create, :new, :show]
  resources :games, only: [:create, :new, :show]
end
