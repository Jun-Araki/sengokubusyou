# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "posts#index"
  devise_for :users
  resources :posts do
    resource :likes, only: %i[create destroy]
  end
  resource :users, only: :show
end
