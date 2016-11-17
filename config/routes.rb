Rails.application.routes.draw do
  namespace :admin do
    root "static_pages#home"
    resources :categories
    resources :products
    resources :orders
    get "statistics" => "statistics#index"
  end
  root "static_pages#home"
  resources :suggestions
  devise_for :users, controllers: {omniauth_callbacks: "callbacks",
    registrations: "users/registrations"}
  resources :products, only: [:index, :show]
  resources :carts
  resources :orders
end

