Rails.application.routes.draw do
  devise_for :users

  resources :lists

  resources :tasks

  get 'home/index'
  get 'home/dashboard'

  authenticated do
    root to: 'lists#index', as: :authenticated
  end

  root to: 'home#index'
end
