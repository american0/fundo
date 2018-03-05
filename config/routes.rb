Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'

  get '/profile', to: 'users#show', as: 'user_profile'

  resources :foundations, only: [:new, :create, :show, :index] do
    member do
      resources :pledges, only: [:new, :create, :cancel]
      resources :projects, only: [:new, :create, :show]
    end
  end

  resources :pledges, only: [:show]
end
