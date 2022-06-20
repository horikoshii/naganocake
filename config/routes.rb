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

  resources :items,only: [:index]

  namespace :customer do
    resources :items,only: [:index]
  end

   namespace :admin do
    resources :homes,only: [:top]
    resources :genres,only: [:index,:show, :edit, :update,:create]
    resources :items,only: [:new,:index,:create,:show,:edit,:update]
    resources :customers,only: [:index,:show,:edit,:update]
  end
end
