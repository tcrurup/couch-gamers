Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#new'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#delete'

  post '/add_to_current_users_games/:game_id' => 'users#add_game'
  post '/remove_from_collection/:game_id' => 'users#remove_game'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/users/facebook_users' => 'users#facebook_users'

  post '/games/favorite/:id' => 'games#favorite', as: "game_favorite"
  

  resources :developers do
    resources :games do 
      resources :users, only: [:index]
    end
    resources :users
  end

  resources :games, only: [:index]

  resources :users
  
end
