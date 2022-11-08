Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index'
  get 'dashboard/index'
  get 'users/new'
  get 'sessions/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root    'static_pages#home'
  get     '/login'   =>  'sessions#new'
  post    '/login'   =>  'sessions#create'
  get     '/logout'  =>  'sessions#destroy'
  get "/messages", to: "messages#index"
  resources :users
  resources :groups
  resources :posts

  
end
