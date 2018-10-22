Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#show', page: "shop"

  resources :users
  resources :products do
    resources :cart_entries, only: [:create]
  end
  resources :cart_entries, except: [:create]
  resources :orders

  get "/auth/:provider/callback", to: "sessions#login", as: "login"
  delete "/logout", to: "sessions#destroy", as: "logout"

  post 'products/:id/review', to:'products#review', as: 'review'
  get 'pages/:page', to: 'pages#show', as: 'page'
end
