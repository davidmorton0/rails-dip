Rails.application.routes.draw do
  root to: 'main#index'

  resources :games, only: [:index, :show, :update] do
    resources :players
  end
  resources :players do
    resources :orders
  end
end
