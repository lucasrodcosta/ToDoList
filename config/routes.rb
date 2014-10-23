Rails.application.routes.draw do
  devise_for :users

  resources :lists, except: :show do
    get  :explore,            on: :collection
    post :mark_as_favorite,   on: :member
    post :unmark_as_favorite, on: :member
  end

  resources :tasks, except: :show do
    post :mark_as_done,   on: :member
    post :mark_as_undone, on: :member
  end

  get 'home/index'

  authenticated do
    root to: 'lists#index', as: :authenticated
  end

  root to: 'home#index'
end
