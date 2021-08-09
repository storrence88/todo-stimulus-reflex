Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'tasks/show'
  root 'lists#index'
  resources :lists, only: %i[new create destroy] do
    resources :tasks, only: :show do
      resources :comments, only: :create
    end
  end
end
