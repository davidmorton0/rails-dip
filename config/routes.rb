Rails.application.routes.draw do
  resources :games, only: [:index, :show, :update] do
    resources :players
  end
  resources :players do
    resources :orders
  end
end
