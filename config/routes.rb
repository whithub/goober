Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: "admins/sessions" }
  devise_for :users, controllers: { sessions: "users/sessions" }

  root 'welcome#index'

  namespace :admins do
    # get 'rides', to: 'rides#index'
    resources :rides
  end

  namespace :users do
    # get '/users/rides', to: 'users/rides#index'
    resources :rides
  end

end
