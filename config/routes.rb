Rails.application.routes.draw do
  
  devise_for :users 
   resources :users do
  put :favorite, on: :member
end

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
  post 'books/:id/favorite' => "books#favorite"

  get 'dashboard' => 'books#dashboard', as: "user_dashboard"

  end
