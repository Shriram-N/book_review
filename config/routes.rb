Rails.application.routes.draw do
  resources :reviews
  devise_for :users
  resources :books do
    member do
      get "Like", to:"books#upvote"
      get "dilike", to:"books#downvote"
    end
    put :favorite, on: :member

  end

  root 'books#index'

  end
