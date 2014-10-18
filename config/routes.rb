Rails.application.routes.draw do
  devise_for :users

  resources :lists

  resources :tasks

  get 'home/index'
  get 'home/dashboard'

  root to: 'home#dashboard'
end
