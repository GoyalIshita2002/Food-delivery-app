# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_12_073822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "jti", null: false
    t.string "user_name"
    t.boolean "is_verified"
    t.string "phone"
    t.boolean "is_blocked", default: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["jti"], name: "index_admin_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "avg_pricings", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.integer "members"
    t.float "price"
    t.float "min_price"
    t.float "max_price"
    t.string "currency_symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_avg_pricings_on_restaurant_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.integer "quantity", default: 1
    t.decimal "ordered_price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "unit_price"
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["itemable_type", "itemable_id"], name: "index_cart_items_on_itemable"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.decimal "total_amount", default: "0.0"
    t.integer "item_count", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "address", null: false
    t.string "zip_code", null: false
    t.string "state", null: false
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "city", default: ""
    t.boolean "is_default", default: false
    t.integer "address_type", default: 0
    t.index ["customer_id"], name: "index_customer_addresses_on_customer_id"
  end

  create_table "customer_feedbacks", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "title"
    t.string "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_customer_feedbacks_on_order_id"
  end

  create_table "customer_margins", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.integer "margin_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_customer_margins_on_restaurant_id"
  end

  create_table "customer_otps", force: :cascade do |t|
    t.string "otp", limit: 4
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_otps_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "phone"
    t.string "std_code"
    t.date "dob"
    t.date "doa"
    t.string "jti", null: false
    t.boolean "is_verified", default: false
    t.boolean "is_blocked", default: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["jti"], name: "index_customers_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "delivery_charges", force: :cascade do |t|
    t.float "min_distance"
    t.float "max_distance"
    t.integer "charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_type"
    t.string "device_token"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_devices_on_customer_id"
  end

  create_table "dish_add_ons", force: :cascade do |t|
    t.string "name"
    t.integer "max_quantity"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_dish_add_ons_on_restaurant_id"
  end

  create_table "dish_categories", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "dish_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_categories_on_dish_id"
    t.index ["dish_type_id"], name: "index_dish_categories_on_dish_type_id"
  end

  create_table "dish_items", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dish_add_on_id"
    t.index ["dish_add_on_id"], name: "index_dish_items_on_dish_add_on_id"
    t.index ["dish_id"], name: "index_dish_items_on_dish_id"
    t.index ["item_id"], name: "index_dish_items_on_item_id"
  end

  create_table "dish_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id", null: false
    t.boolean "is_popular", default: false
    t.boolean "is_available", default: true
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "documenter_type", null: false
    t.bigint "documenter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documenter_type", "documenter_id"], name: "index_documents_on_documenter"
  end

  create_table "driver_otps", force: :cascade do |t|
    t.string "otp"
    t.bigint "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_driver_otps_on_driver_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "full_name"
    t.date "dob"
    t.string "email"
    t.text "address"
    t.string "phone"
    t.string "std_code"
    t.boolean "is_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["jti"], name: "index_drivers_on_jti", unique: true
  end

  create_table "fav_dishes", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_fav_dishes_on_customer_id"
    t.index ["dish_id"], name: "index_fav_dishes_on_dish_id"
  end

  create_table "fav_restaurants", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_fav_restaurants_on_customer_id"
    t.index ["restaurant_id"], name: "index_fav_restaurants_on_restaurant_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.bigint "dish_add_on_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_quantity"
    t.integer "max_quantity"
    t.index ["dish_add_on_id"], name: "index_items_on_dish_add_on_id"
  end

  create_table "open_days", force: :cascade do |t|
    t.string "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_hours", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "day"
    t.index ["restaurant_id"], name: "index_open_hours_on_restaurant_id"
  end

  create_table "order_agents", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_order_agents_on_driver_id"
    t.index ["order_id"], name: "index_order_agents_on_order_id"
  end

  create_table "order_notes", force: :cascade do |t|
    t.text "content"
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_notes_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "cart_id", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "customer_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.datetime "time"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["customer_address_id"], name: "index_orders_on_customer_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurant_addresses", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.string "street"
    t.string "address1"
    t.string "zip_code"
    t.string "state"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address2"
    t.string "city"
    t.string "state_code"
    t.index ["latitude"], name: "index_restaurant_addresses_on_latitude"
    t.index ["longitude"], name: "index_restaurant_addresses_on_longitude"
    t.index ["restaurant_id"], name: "index_restaurant_addresses_on_restaurant_id"
  end

  create_table "restaurant_categories", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_restaurant_categories_on_category_id"
    t.index ["restaurant_id"], name: "index_restaurant_categories_on_restaurant_id"
  end

  create_table "restaurant_cuisines", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "cuisine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_restaurant_cuisines_on_cuisine_id"
    t.index ["restaurant_id"], name: "index_restaurant_cuisines_on_restaurant_id"
  end

  create_table "restaurant_files", force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_files_on_restaurant_id"
  end

  create_table "restaurant_margins", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.integer "margin_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_margins_on_restaurant_id"
  end

  create_table "restaurant_menus", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.decimal "min_price"
    t.decimal "max_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_menus_on_restaurant_id"
  end

  create_table "restaurant_open_days", force: :cascade do |t|
    t.bigint "open_day_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["open_day_id"], name: "index_restaurant_open_days_on_open_day_id"
    t.index ["restaurant_id"], name: "index_restaurant_open_days_on_restaurant_id"
  end

  create_table "restaurant_ratings", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating", default: 0
    t.index ["customer_id"], name: "index_restaurant_ratings_on_customer_id"
    t.index ["restaurant_id"], name: "index_restaurant_ratings_on_restaurant_id"
  end

  create_table "restaurant_users", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "admin_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_restaurant_users_on_admin_user_id"
    t.index ["restaurant_id"], name: "index_restaurant_users_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.float "avg_rating"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open_for_orders", default: false
    t.string "registration_date"
    t.string "std_code"
    t.boolean "lock_menu", default: false
    t.boolean "suspended", default: false
  end

  create_table "service_locations", force: :cascade do |t|
    t.string "address"
    t.string "street"
    t.string "state"
    t.string "country"
    t.integer "vehicle"
    t.decimal "latitude"
    t.decimal "longitude"
    t.bigint "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_service_locations_on_driver_id"
  end

  create_table "split_hours", force: :cascade do |t|
    t.time "start_at"
    t.time "end_at"
    t.bigint "open_hour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["open_hour_id"], name: "index_split_hours_on_open_hour_id"
  end

  create_table "super_admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "jti", null: false
    t.index ["email"], name: "index_super_admins_on_email", unique: true
    t.index ["jti"], name: "index_super_admins_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_super_admins_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "avg_pricings", "restaurants"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "customers"
  add_foreign_key "customer_addresses", "customers"
  add_foreign_key "customer_feedbacks", "orders"
  add_foreign_key "customer_margins", "restaurants"
  add_foreign_key "customer_otps", "customers"
  add_foreign_key "devices", "customers"
  add_foreign_key "dish_add_ons", "restaurants"
  add_foreign_key "dish_categories", "dish_types"
  add_foreign_key "dish_categories", "dishes"
  add_foreign_key "dish_items", "dish_add_ons"
  add_foreign_key "dish_items", "dishes"
  add_foreign_key "dish_items", "items"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "driver_otps", "drivers"
  add_foreign_key "fav_dishes", "customers"
  add_foreign_key "fav_dishes", "dishes"
  add_foreign_key "fav_restaurants", "customers"
  add_foreign_key "fav_restaurants", "restaurants"
  add_foreign_key "items", "dish_add_ons"
  add_foreign_key "open_hours", "restaurants"
  add_foreign_key "order_agents", "drivers"
  add_foreign_key "order_agents", "orders"
  add_foreign_key "order_notes", "orders"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "customer_addresses"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "restaurant_addresses", "restaurants"
  add_foreign_key "restaurant_categories", "categories"
  add_foreign_key "restaurant_categories", "restaurants"
  add_foreign_key "restaurant_cuisines", "cuisines"
  add_foreign_key "restaurant_cuisines", "restaurants"
  add_foreign_key "restaurant_files", "restaurants"
  add_foreign_key "restaurant_margins", "restaurants"
  add_foreign_key "restaurant_menus", "restaurants"
  add_foreign_key "restaurant_open_days", "open_days"
  add_foreign_key "restaurant_open_days", "restaurants"
  add_foreign_key "restaurant_ratings", "customers"
  add_foreign_key "restaurant_ratings", "restaurants"
  add_foreign_key "restaurant_users", "admin_users"
  add_foreign_key "restaurant_users", "restaurants"
  add_foreign_key "service_locations", "drivers"
  add_foreign_key "split_hours", "open_hours"
end
