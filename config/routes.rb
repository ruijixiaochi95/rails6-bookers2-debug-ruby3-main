Rails.application.routes.draw do
  get 'group_users/create'
  get 'group_users/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search_form", to: "users#search_form"
  end
  resources :groups,only: [:index, :show, :edit, :update, :create, :new] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end
  resources :chats, only: [:show, :create]
  get "search" => "searches#search"
  get 'home/about' => 'homes#about', as: 'about'
  get 'tagsearches/search', to: 'tagsearches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end