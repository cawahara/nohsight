Rails.application.routes.draw do
  get '/dashboard',     to: 'mockups#dashboard', as: 'dashboard'

  get '/search/:id',    to: 'mockups#search', as: 'search'

  get '/detail/:id',    to: 'mockups#detail', as: 'detail'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
