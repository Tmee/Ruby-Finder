Rails.application.routes.draw do
  root 'search#create'
  get 'search', to: 'search#create'
  resources :search
end
