Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: "users/registrations" }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  post 'likes/:id/create', to: "likes#create", as: 'create_like'
  delete 'likes/:id/destroy', to: "likes#destroy", as: 'destroy_like'

  post 'articles/attach', to: 'articles#attach'

  # get 'users/:id/profile', to: "users#show", as: 'user_profile'

  resources :users, only: [:show, :edit, :update]  
  resources :articles do
    collection do
      get "create_done"
    end

    member do
      get "update_done"
      get "destroy_caution"      
      get "destroy_done"
    end

  end

  resources :relationships, only: [:create, :destroy]

end
