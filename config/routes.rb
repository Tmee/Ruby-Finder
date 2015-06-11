Rails.application.routes.draw do
  root 'search#create'

  get "/auth/twitter/callback", to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  resources :users

  get 'search', to: 'search#results'
  get '/code' => redirect("https://github.com/Tmee/job_finder")
end