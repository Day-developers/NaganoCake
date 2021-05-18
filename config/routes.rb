Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_items, only: [:update]
    end
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    get "/customers/my_page" => "customers#show"
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resource :customers, only: [:edit, :update]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers, controllers: {
    sessions: "public/sessions",
    passwords: "public/passwords",
    registrations: "public/registrations"
  }

end