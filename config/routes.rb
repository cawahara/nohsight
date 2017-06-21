Rails.application.routes.draw do

 # StaticPage用ルーティング
  get '/dashboard',       to: 'static_pages#dashboard',   as: 'dashboard'
  get '/search',          to: 'static_pages#search',      as: 'search'
  get '/about',           to: 'static_pages#about',       as: 'about'
  get '/help',            to: 'static_pages#help',        as: 'help'
  get '/convention',      to: 'static_pages#convention',  as: 'convention'

  # User用ルーティング
  resources 'users'

  # TODO: 必要なアクションのみ設定する予定
  # Event用ルーティング
  resources 'events'
  get '/edit_manage', to: 'events#edit_manage', as: 'edit_event_manage'
  get '/events/:id/edit_port', to: 'events#edit_port', as: 'edit_event_port'
  get '/events/:id/edit_place', to: 'events#edit_place', as: 'edit_event_place'
  patch '/events/:id/edit_place', to: 'events#update_place', as: 'event_place'

  # EventProgram用ルーテイング
  resources 'event_programs', only: [:edit, :update]

  # EventPerformer用ルーティング
  resources 'event_performers', only: [:edit, :update]

  # Ticket用ルーティング
  resources 'tickets', only: [:edit, :update]

  # Place用ルーティング
  resources 'places'

  # Sessions用ルーティング
  get     '/login',        to: 'sessions#new'
  post    '/login',        to: 'sessions#create'
  delete  '/logout/:id',   to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
