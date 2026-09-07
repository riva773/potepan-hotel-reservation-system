Rails.application.routes.draw do
  get "users/account", to: "users#account"
  get "users/profile", to: "users#profile"
  get "users/profile/edit", to: "users#edit", as: :edit_users_profile
  patch "users/profile/update", to: "users#update", as: :update_users_profile
  get "hotels/own", to: "hotels#own"
  resources :hotels
  resources :reservations, only: [ :index, :update, :destroy, :edit, :create ]
  devise_for :users
  root "pages#home"
  post "reservations/confirm", to: "reservations#confirm"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
