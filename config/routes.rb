Rails.application.routes.draw do

  devise_for :admins
  devise_for :users, controllers: { sessions: "users/sessions" }

  root 'welcome#index'

  get '/users/rides', to: 'users/rides#index'

end
