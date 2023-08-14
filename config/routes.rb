Rails.application.routes.draw do
  namespace :v1 do
    namespace :admin_users do
      post 'documents/create'
      get 'restaurants/details'
    end
    get 'admin_user/check_account_availability'
    get 'restaurants/index'
    get 'restaurants/create'
    get 'restaurants/update'

    namespace :restaurant_owner do
      put 'restaurants/:id/update', to: "restaurants#update", format: :json
      post 'restaurant/:restaurant_id/dishes', to: "dishes#create", format: :json
      put 'restaurant/:restaurant_id/dishes/:id', to: "dishes#update", format: :json
      get 'restaurant/:restaurant_id/dishes/:id', to: "dishes#show", format: :json
      get 'restaurant/:restaurant_id/dishes', to: "dishes#index", format: :json
    end
  end
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    registrations: 'admin_users/registrations',
    passwords: 'admin_users/passwords'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
end
