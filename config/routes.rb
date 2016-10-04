Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  resources :charges, only: [:new, :create]
  post 'refund' => 'charges#refund'
  root to: 'welcome#index'
end
