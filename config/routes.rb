Rails.application.routes.draw do
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "orders#index"

  resources :orders do
    member do
      get :remove_an_item
      get :add_an_item
    end
  end
end
