Rails.application.routes.draw do

 # StaticPage用ルーティング
  get '/dashboard'      , to: 'static_pages#dashboard'   , as: 'dashboard'
  get '/about'          , to: 'static_pages#about'       , as: 'about'
  get '/help'           , to: 'static_pages#help'        , as: 'help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
