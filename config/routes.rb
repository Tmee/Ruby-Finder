Rails.application.routes.draw do
  root 'search#create'
  get 'search', to: 'search#create'
  get '/code' => redirect("https://github.com/Tmee/job_finder")
  resources :search
end
