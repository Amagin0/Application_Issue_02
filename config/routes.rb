Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end
    
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update]do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  root to: "homes#top"
  get 'home/about' => 'homes#about'
  get '/search' => 'searches#search'
end