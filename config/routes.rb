Rails.application.routes.draw do


  devise_for :customers,skip: [:passwords,], controllers: {
    sessions:      'customer/sessions',
    registrations: 'customer/registrations'
    }


  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions:      'admin/sessions',
    }

  root to: "homes#top"
  post '/admin/genres/:id' => 'admin/genres#edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   namespace :admin do
    resources :genres,only: [:index,:show, :edit, :update]
    resources :items,only: [:new,:index]
  end
end
