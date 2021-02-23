Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "rooms#index"

  #ここでアクションを指定しないとrails routesのprefixに表示されない。
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create,:destroy] do
    resources :messages, only: [:index, :create] #index,createはメッセージ送信に必要
  end
end