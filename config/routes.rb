Rails.application.routes.draw do
  
  get 'users/index'
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  # post 'users', to: 'users#create'
end