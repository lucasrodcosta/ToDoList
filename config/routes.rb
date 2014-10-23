Rails.application.routes.draw do
  devise_for :users

  resources :lists, except: :show

  resources :tasks, except: :show do
    post :mark_as_done, on: :member
    post :mark_as_undone, on: :member
  end

  get 'home/index'
  get 'home/dashboard'

  authenticated do
    root to: 'lists#index', as: :authenticated
  end

  root to: 'home#index'
end
