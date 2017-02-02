Rails.application.routes.draw do
  root 'todo_items#index'

  resources :todo_items
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
