Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index]
  resources :friend_requests, only: [:index, :destroy]
  root to: "posts#index"
  resources :posts
  resources :profiles, except: [:index]
  resources :friends, only: [:destroy]
end
