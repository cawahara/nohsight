# frozen_string_literal: true

Rails.application.routes.draw do

   # StaticPage用ルーティング
   get '/dashboard', to: 'static_pages#dashboard', as: 'dashboard'
   get '/search',          to: 'static_pages#search',      as: 'search'
   get '/about',           to: 'static_pages#about',       as: 'about'
   get '/help',            to: 'static_pages#help',        as: 'help'
   get '/convention',      to: 'static_pages#convention',  as: 'convention'

   # rooting
   root to: 'static_pages#dashboard'

   # User用ルーティング
   resources 'users'

   # TODO: 必要なアクションのみ設定する予定
   # Event用ルーティング
   resources 'events'
   get '/manage', to: 'events#manage', as: 'event_manage'
   get '/events/:id/edit_port', to: 'events#edit_port', as: 'edit_event_port'
   get '/event_places/:id/edit', to: 'events#edit_place', as: 'edit_event_place'
   patch '/event_places/:id', to: 'events#update_place', as: 'event_place'

   # EventProgram用ルーテイング
   resources 'event_programs', only: [:edit, :update]

   # EventPerformer用ルーティング
   resources 'event_performers', only: [:edit, :update]

   # Ticket用ルーティング
   resources 'tickets', only: [:edit, :update]

   # Place用ルーティング
   resources 'places'

   # Program用ルーティング
   resources 'programs'

   # Performer用ルーティング
   resources 'performers'

   # UserEvent洋ルーティング
   post '/user_events/:id', to: 'user_events#create', as: 'user_events'
   delete '/user_events/:id', to: 'user_events#destroy', as: 'user_event'

   # Sessions用ルーティング
   get     '/login',        to: 'sessions#new'
   post    '/login',        to: 'sessions#create'
   get     '/logout/:id',   to: 'sessions#destroy', as: 'logout'

   # Request用ルーティング
   resources 'requests', only: [:index, :show, :update]

   # Bookmark用ルーティング
   resources 'bookmarks', only: [:index, :update, :destroy]

   # AccountConfirmation用ルーティング
   get      '/confirmation/new',  to: 'account_confirmations#new', as: 'new_confirmation'
   get      '/confirmation/edit', to: 'account_confirmations#edit', as: 'edit_confirmation'
   post     '/confirmation',      to: 'account_confirmations#create'

   # PasswordReset用ルーティング
   get      '/password_resets/new', to: 'password_resets#new',    as: 'new_password_reset'
   get      '/password_resets/edit', to: 'password_resets#edit',  as: 'edit_password_reset'
   post     '/password_resets',      to: 'password_resets#create'
   patch    '/password_resets',      to: 'password_resets#update'

  # Feedback用ルーティング
   get      '/feedback', to: 'feedbacks#new'
   post     '/feedback', to: 'feedbacks#create'

   # JoinHistory用ルーティング
   resources   'join_histories', only: [:index, :update, :destroy]

   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
