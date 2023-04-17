Rails.application.routes.draw do

  # 顧客用
  scope module: :public do
    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about'
    # customers
    get '/customers/my_page' => 'customers#show'
    get '/customers/info/edit' => 'customers#edit'
    patch '/customers/info' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
    # addresses
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    # items
    resources :items, only: [:index, :show]
    # cart_items
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'

  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
  end



  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
