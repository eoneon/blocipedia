Rails.application.routes.draw do

  get 'charges/create'

  get 'charges/new'

  devise_for :users
  resources :users
  resources :wikis
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'
end
