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
    get 'countries', to: "miscellaneous#list"

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
      get 'orders/:order_id', to: "orders#show"
      get 'orders', to: "orders#index"
      put 'orders/:order_id', to: "orders#update"
      get 'total_analysts',to:"dashboards#analysts"
      get 'weekly_earning',to:"dashboards#weekly_update"
      get 'profile',to: "profile#show"
    end

    namespace :super_admin do
      resources :restaurants
      post 'restaurant/:restaurant_id/documents', to: "documents#create"
      get 'restaurant/:restaurant_id/documents', to: "documents#index"
      delete 'restaurant/:restaurant_id/documents/:id', to: "documents#destroy"
      post 'assign_driver/:order_id', to: "orders#assign_driver"
      put 'accept_order/:order_id', to: "orders#accept_order"
      get 'placed_order',to: "orders#placed_order"
      get 'order_without_driver', to: "orders#orders_without_agent"
      post 'restaurant/:restaurant_id/order_status', to: "orders#order_status"
      get 'orders/statistics', to: "orders#order_statistics"
      get 'placed_orders_by_hours', to: "orders#placed_orders_by_hours"
      get 'ongoing_orders_statistics', to: "orders#orders_ongoing_stats"
      get 'orders_unfilled_stats', to: "orders#orders_unfilled_stats"
      get 'orders', to: "orders#index"
      get 'drivers/:driver_id/revenue_by_day', to: "driver#revenue_by_day"
      get 'drivers',to:"driver#index"
      post 'delivery_charges/upsert', to: 'driver#upsert', as: 'upsert_delivery_charge'
      get 'drivers/:driver_id/orders',to:"driver#driver_order_list"
      get 'users',to:"users#index"
      get 'user/:id',to:"users#show"
      get 'categories',to:"categories#index"
      put 'dish_types', to: "dish_type#update"
      post 'dish_type',to:"dish_type#create"
      get 'customer_users',to:"customer_user#index"
      get 'customer_user/:id',to:"customer_user#show"
      get 'restaurant/:id/edit',to:"restaurants#edit"
      post 'blob_creation', to: "restaurants#blob_creation"
    end 

    namespace :customer do
      post 'resend_otp', to: "profile#resend_otp"
      post 'orders', to: "orders#create"
      put 'orders/:order_id', to: "orders#denied"
      get 'check_email_availability', to: "miscellaneous#check_email_availability" 
      post 'verify_customer', to: "profile#verify_otp"
      post 'forget_password',to:"profile#forget_password"
      post 'reset_password',to:"profile#reset_password"
      put 'profile', to: "profile#update"
      post 'addresses', to: "customer_addresses#create"
      put 'addresses/:id', to: "customer_addresses#update"
      get 'addresses', to: "customer_addresses#index"
      post 'delete_avatar', to: "profile#delete_avatar"
      patch 'update_password', to: "profile#update_password"  
      patch 'update_phone', to: "profile#update_phone"
      get 'orders', to: "orders#index"
      get 'orders/:order_id', to: "orders#show"
      post 'order/:order_id/customer_feedback', to: "orders#customer_feedback"
      resources :restaurants, only: [ :index, :show ]
      resources :dishes, only: [ :index, :show ]
      resources :cart_items
      get 'show_cart', to: "carts#show"
      get 'grouped_dishes', to: "dishes#grouped_dishes"
      post 'favourites/add_restaurant', to: "favourites#add_restaurant"
      post 'favourites/add_dish', to: "favourites#add_dish"
      delete 'favourites/remove_restaurant', to: "favourites#remove_restaurant"
      delete 'favourites/remove_dish', to: "favourites#remove_dish"
      get 'favourite_restaurants', to: "favourites#list_restaurants"
      get 'favourite_dishes', to: "favourites#list_dishes"
      post 'restaurant_ratings/add_rating' , to: "restaurant_ratings#add_rating"
      get 'order_history', to: "orders#order_history"
      get 'categories', to: "categories#index"
      get 'profile',to: "profile#show"
      post ':customer_id/devices',to: "device#create"
    end

    namespace :driver do
      post 'register', to: "registration#create"
      post 'sign_in', to: "session#create"
      put 'update', to: "profile#update"
      post 'delete_avatar',to:"profile#delete_avatar"
      post 'service_details',to:"service_details#create"
      post 'documents', to: "documents#create"
      get 'documents', to: "documents#index"
      delete 'documents/:id', to: "documents#destroy"
      get 'profile',to:"profile#show"
      delete 'sign_out', to:"session#destroy"
      post 'resend_otp', to: "profile#resend_otp"
      put 'orders/:order_id', to: "orders#update"
      get ':driver_id/orders', to: "orders#index"
    end
  end
  devise_for :admin_user, path: 'v1/restaurant_owner', controllers: { sessions: 'v1/restaurant_owner/sessions' }
  devise_for :customers, path: 'v1/customer', controllers: { 
    sessions: 'v1/customer/sessions',
    registrations: 'v1/customer/registrations'
  }
end
