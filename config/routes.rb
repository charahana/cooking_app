Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  get "search" => "searches#search"
  resources :users, only: [:show, :edit, :update, :index] do
    collection do
      get 'mypage', to: 'users#mypage', as: :mypage
      delete 'withdraw'
    end
  end

  resources :recipes do
    resources :comments, only: [:create, :destroy]
  end

  root to: 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
