Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :players, only: [:create]
  resources :games, only: [:index, :show, :create]
  resources :game_players, only: [:update, :create]

  mount ActionCable.server => '/cable'
end
