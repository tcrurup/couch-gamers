Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#new'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#delete'

  post '/add_to_current_users_games/:game_id' => 'users#add_to_current_users_games'
  

  resources :developers, only: [:create, :new, :index, :show] do
    resources :games do 
      resources :users, only: [:index]
    end
  end

  resources :games, only: [:index]

  resources :users, only: [:create, :edit, :index, :new, :show]
  
end
