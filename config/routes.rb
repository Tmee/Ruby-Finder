Rails.application.routes.draw do
  root 'search#create'
  get 'search', to: 'search#results'
  get '/code' => redirect("https://github.com/Tmee/job_finder")
end