Rails.application.routes.draw do
  get 'tasks/show'
  devise_for :users
  root 'lists#index'
  resources :lists, only: %i[new create destroy] do
    resources :tasks, only: :show do
      resources :comments, only: :create
    end
  end
end
