Rails.application.routes.draw do
  root to: "posts#top"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :posts do
    resource :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
    collection do
      get :ranks, :prefecture, :top, :info
    end
  end

  resources :users do
    member do
      get :following, :followers, :likes, :comments
    end
  end

  resources :relationships, only: %i[create destroy]
end
