# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "posts#index"
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :posts do
    resource :likes, only: %i[create destroy]
  end
  resource :users, only: :show
end
