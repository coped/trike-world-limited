Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/about-me', to: 'pages#about', as: 'about'
  get '/contact',  to: 'pages#contact'
end
