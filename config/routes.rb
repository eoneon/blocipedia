Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :wikis
  resources :charges, only: [:new, :create]
  post 'refund' => 'charges#refund'
  root to: 'welcome#index'
end
