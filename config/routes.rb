Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }
  devise_for :users, controllers: { sessions: "users/sessions" }

  root 'welcome#index'

  namespace :admins do
    resources :rides do
      member do
        get :ride_accepted
        get :picked_up
        get :dropped_off
      end
    end
  end

  namespace :users do
    resources :rides
  end

end
