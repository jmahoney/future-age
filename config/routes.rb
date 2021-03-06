Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :feeds
  end

  resource :login

  resources :items, only: [:index, :update] do
    member do
      patch 'toggle_starred'
    end
    collection do
      get 'starred'
    end
  end

  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
