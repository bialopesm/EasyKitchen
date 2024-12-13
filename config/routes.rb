Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  root "bookmarks#index"

  resources :ingredients
  resources :recipes, only: [:index, :show, :new, :create] do
    resources :comments, only: [:new, :create, :destroy]
  end
  resources :bookmarks, only: [:index, :new, :create, :show, :destroy]
end
