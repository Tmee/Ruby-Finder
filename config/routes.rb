Rails.application.routes.draw do
  root 'search#create'

  get "/auth/twitter/callback", to: "sessions#create"
  get "/auth/twitter", as: "login"
  delete '/logout', to: "sessions#destroy"
  resources :users, only: [:create]
  resources :notes, only: [:create, :show, :destroy, :update]

  get 'search', to: 'search#results'
  get '/code' => redirect("https://github.com/Tmee/ruby-finder")
end