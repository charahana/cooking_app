Rails.application.routes.draw do
  namespace :admins do
    root to: 'dashboard#index'
    resources :users, only: [:index, :show, :destroy]
    resources :recipes, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  devise_for :admins, skip: [:registrations], controllers: {
    sessions: 'admins/sessions'
  }
  
  devise_for :users
  get "search" => "searches#search"
  resources :users, only: [:show, :edit, :update, :index] do
    collection do
      get 'mypage', to: 'users#mypage', as: :mypage
      delete 'withdraw'
    end
    resource :relationship, only: [:create, :destroy]
    member do
      get :followers
      get :followings
    end
  end

  resources :recipes do
    resource :like, only: [:create]
    resources :comments, only: [:create, :destroy]
  end

  resources :likes, only: [:index]

  resources :tags, only: [:show, :index]

  root to: 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
