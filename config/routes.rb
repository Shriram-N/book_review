Rails.application.routes.draw do
  
  devise_for :users
  resources :books do
      resources :reviews ,except: [:show,:index]
      collection do
        get 'search'
      end
    member do
      get "Like", to:"books#upvote"
      get "dilike", to:"books#downvote"
    end
      put :favorite, on: :member

  end

  root 'books#index'

  end
