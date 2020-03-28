Rails.application.routes.draw do
  get 'excerpts/new'
  get 'signs/new'
  get 'sources/new'
  get 'projects/new'
  get 'tags/new'
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :projects
  resources :sources
  resources :tags, except: [:new]
  resources :signs, except: [:show]
  resources :excerpts
end