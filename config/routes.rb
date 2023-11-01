Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to:"rooms#index"
  resources :users do
  end
  resources :rooms do
  end
end
