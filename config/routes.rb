Rails.application.routes.draw do
  root 'static_pages#home'
  resources :sessions,    only: [:create]
  resources :activation,  only: [:show, :update]
  resources :users,       only: [:index, :create, :update, :show, :destroy] do
    collection do
      get 'forgotten_password'
    end
    member do
      put 'reset_password'
      put 'change_password'
    end
  end
  post 'sessions/social_auth/callback', to: 'sessions#social_create'
  resources :tours,     only: [:show, :create, :update, :destroy, :index] do
    member do
      get 'mark'
      get 'reviews'
    end
  end
  resources :helpers,   only: [:index]
  resources :bookings,  only: [:create]
  post '/checkout',     to: 'checkout#create'
  resources :webhooks,  only: :create
  resources :reviews,   only: [:create, :destroy] do
    member do
      get 'like'
      post 'report'
      get 'hide'
      get 'appear'
      post 'comment'
      get 'comments'
    end
  end
  resources :comments,  only: [:create, :destroy] do
    member do
      get 'like'
      post 'report'
      get 'hide'
      get 'appear'
      get 'replies'
    end
  end


  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?
end
