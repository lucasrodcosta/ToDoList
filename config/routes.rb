Rails.application.routes.draw do
  devise_for :users

  resources :lists

  get 'home/index'

  root to: 'lists#index'
end
