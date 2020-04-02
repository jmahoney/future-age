Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :feeds
  end

  resources :items, only: [:index, :update]

  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
