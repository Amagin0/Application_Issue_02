Rails.application.routes.draw do
  get 'charts/index'
  get 'chart/index'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
      get 'search' => 'users#search'
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :chats, only: [:create]
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  root to: "homes#top"
  get 'home/about' => 'homes#about'
  get '/search' => 'searches#search'
  get 'chat/:id' =>'chats#show', as: 'chat'
  get 'search/book' => "homes#search"
end