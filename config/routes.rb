Rails.application.routes.draw do
  namespace :admin do
    root to: "homes#top"
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resource :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all]
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

end
