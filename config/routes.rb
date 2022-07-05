Rails.application.routes.draw do

  root to: "homes#top"

  get "/about", to: "homes#about"
  get "/admin", to: "admin/homes#top"



  devise_for :customers,skip: [:passwords,], controllers: {
    sessions:      'customer/sessions',
    registrations: 'customer/registrations'
    }


  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions:      'admin/sessions',
    }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  scope module: :customer do
    post "orders/comfirm" => "orders#comfirm"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    delete "cart_items/destroy" => "cart_items#destroy"
    get "item/index" => "items#serch",as: "serch"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resources :items,only: [:index,:show,:delete,:update]
    resources :customers,only: [:show,:edit,:update,:unsubscribe,:withdraw]
    resources :addresses,only: [:index]
    resources :cart_items,only: [:index,:create,:update,:delete,]
    resources :orders,only: [:new,:create]
  end

   namespace :admin do
    resources :homes,only: [:top]
    resources :genres,only: [:index,:show, :edit, :update,:create]
    resources :items,only: [:new,:index,:create,:show,:edit,:update]
    resources :customers,only: [:index,:show,:edit,:update]
  end
end
