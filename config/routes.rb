Rails.application.routes.draw do
  root 'todo_items#index'
  
  resources :todo_items
end
