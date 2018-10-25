Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#show', page: "shop"

  resources :users
  resources :products
  resources :cart_entries
  resources :orders

  patch 'orders/chekout/:id', to: 'orders#update'

  get 'orders/chekout/:id', to: 'orders#checkout', as: 'order_checkout'

  get 'dash', to: 'users#userdash', as: 'userdash'
  get 'manage', to: 'users#manage_orders', as: 'manage_orders'

  get "/auth/:provider/callback", to: "sessions#login", as: "login"
  delete "/logout", to: "sessions#destroy", as: "logout"

  post 'products/:id/review', to:'products#review', as: 'review'
  get 'pages/:page', to: 'pages#show', as: 'page'
end
