Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    devise_for :super_admin, controllers: {
      sessions: 'v1/super_admin/sessions'
    }

    namespace :admin_users do
      post 'documents/create'
      get 'restaurants/details'
    end
    get 'admin_user/check_account_availability'
    get 'restaurants/index'
    get 'restaurants/create'
    get 'restaurants/update'

    namespace :restaurant_owner do
      put 'restaurants/update', to: "restaurants#update"
      post 'dishes', to: "dishes#create"
      put 'dishes/:id', to: "dishes#update"
      get 'dishes/:id', to: "dishes#show"
      get 'dishes', to: "dishes#index" 
      put 'dish/:id/upload_image', to: "dishes#upload_image"
      put '/password', to: "passwords#update"
      get '/dish_types', to: "dishes#types"
      delete 'dish/:id', to: "dishes#destroy"
      get 'grouped_dishes', to: "dishes#dishes_by_type"
      get 'popular_dishes', to: "dishes#popular"
      put 'dishes_availability', to: "dishes#dishes_availability"
      put 'update_popular_dishes', to: "dishes#popular_dishes"
      post 'add_ons', to: "add_ons#create"
      get 'add_ons', to: "add_ons#index"
      put 'add_ons/:id', to: "add_ons#update"
      delete 'add_ons/:id', to: "add_ons#destroy"
      get 'add_ons/:id', to: "add_ons#show"
      put 'profile/update', to: "profile#update"
      post 'profile/upload_image', to: "profile#upload_image"
      get 'countries', to: "countries#index"
    end

    namespace :super_admin do
      post 'restaurants', to: "restaurants#create"
      put 'restaurants/:id', to: "restaurants#update"
      get 'restaurants/:id', to: "restaurants#show"
      post 'restaurant/:restaurant_id/documents', to: "documents#create"
      get 'restaurant/:restaurant_id/documents', to: "documents#index"
    end

    namespace :customer do
      get 'check_email_availability', to: "miscellaneous#check_email_availability" 
      post 'verify_customer', to: "profile#verify_otp"
      put 'profile', to: "profile#update"
      post 'addresses', to: "customer_addresses#create"
      post 'delete_avatar', to: "profile#delete_avatar"
      patch 'update_password', to: "profile#update_password"  
      patch 'update_phone', to: "profile#update_phone"
    end
  end
  
  # devise_for :admin_users, controllers: {
  #   sessions: 'admin_users/sessions',
  #   registrations: 'admin_users/registrations',
  #   passwords: 'admin_users/passwords'
  # }

  


  devise_for :admin_user, path: 'v1/restaurant_owner', controllers: { sessions: 'v1/restaurant_owner/sessions' }
  devise_for :customers, path: 'v1/customer', controllers: { 
    sessions: 'v1/customer/sessions',
    registrations: 'v1/customer/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
end
