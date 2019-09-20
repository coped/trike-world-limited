Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about',                to: 'static_pages#about'
  get '/contact',              to: 'static_pages#contact'

  get '/galleries/charles',    to: 'galleries#charles'
  get '/galleries/tim',        to: 'galleries#tim'
  get '/galleries/red_trike',  to: 'galleries#red_trike'
  get '/galleries/roth_body',  to: 'galleries#roth_body'
  get '/galleries/twin_turbo', to: 'galleries#twin_turbo'
  get '/galleries/misc',       to: 'galleries#misc'
end
