Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/about',                to: 'static_pages#about'
  get    '/contact',              to: 'static_pages#contact'
  get    '/galleries/charles',    to: 'static_pages#charles'
  get    '/galleries/tim',        to: 'static_pages#tim'
  get    '/galleries/red-trike',  to: 'static_pages#red_trike'
  get    '/galleries/roth-body',  to: 'static_pages#roth_body'
  get    '/galleries/twin-turbo', to: 'static_pages#twin_turbo'
  get    '/galleries/misc',       to: 'static_pages#misc'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users, only: [:show, :edit, :update]
  get '/users/:id/edit_password', to: 'users#edit_password'
  resources :posts
  resources :password_resets, only: [:new, :create, :edit, :update]
end
