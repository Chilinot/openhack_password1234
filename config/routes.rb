Rails.application.routes.draw do
  root 'static_pages#home'

  # Static pages
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # Jobs
  resources :jobs
  get '/jobs', to: 'jobs#index'

  # Users
  resources :users
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  # Sessions (login)
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
