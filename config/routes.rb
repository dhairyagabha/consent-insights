require 'sidekiq/web'

Rails.application.routes.draw do
  resources :teams do
    member do
      get     :teams_users, to: 'teams#teams_users'
      post    :teams_users, to: 'teams#add_users'
      put     :teams_users, to: 'teams#update_admin'
      delete  :teams_users, to: 'teams#delete_user'
    end
  end
  resources :properties do
    member do
      get :global_visits, to: 'properties#global_visits'
      get :required_optin, to: 'properties#required_optin'
      get :functional_optin, to: 'properties#functional_optin'
      get :advertising_optin, to: 'properties#advertising_optin'
      get :bounce, to: 'properties#bounce'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'visits/capture', to: 'visits#capture'
      get 'impressions/capture', to: 'impressions#capture'
      get 'consents/capture', to: 'consents#capture'
    end
  end
  draw :madmin
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'

  authenticated :user do
    root to: 'properties#index', as: :authenticated_user_root
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'

    namespace :madmin do
      resources :impersonates do
        post :impersonate, on: :member
        post :stop_impersonating, on: :collection
      end
    end
  end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
end
