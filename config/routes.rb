Rails.application.routes.draw do
  resources :items
  resources :feeds
  root 'index#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
