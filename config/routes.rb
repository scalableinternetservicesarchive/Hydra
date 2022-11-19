Rails.application.routes.draw do
  get 'group_users/new'
  get 'group_users/create'
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

  get     "/messages", to: "messages#index"
  get     "/messages/:userid", to: "messages#show"
  post    "/messages/:userid", to: "messages#create"
  
  get     '/joingroup'=> 'group_users#join'
  get     '/leavegroup'=>'group_users#leave'
  get     '/addtogroup'=>'group_users#create'
  get     '/delfromgroup'=>'group_users#destroy'
  get     '/groupusers'=>'group_users#index'
  get     '/editgroupuser'=>'group_users#edit'
  get     '/transferownership'=>'group_users#transferownership'
  
  get     '/deleteuser'=>'users#destroy'

  get     '/dashboard/show_more_posts'=>'dashboard#show_more_posts'
  get     '/dashboard/show_more_rec_users'=>'dashboard#show_more_rec_users'
  get     '/dashboard/show_more_rec_groups'=>'dashboard#show_more_rec_groups'

  
  resources :users do
    get '/page/:page', action: :index, on: :collection
  end
  resources :groups do
    get '/page/:page', action: :index, on: :collection
  end
  resources :posts do
    get '/page/:page', action: :index, on: :collection
    resources :comments
  end

  
end
