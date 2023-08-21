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

ActiveRecord::Schema[7.0].define(version: 2023_08_21_111950) do
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

  create_table "dish_categories", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "dish_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_categories_on_dish_id"
    t.index ["dish_type_id"], name: "index_dish_categories_on_dish_type_id"
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
    t.index ["restaurant_id"], name: "index_open_hours_on_restaurant_id"
  end

  create_table "restaurant_addresses", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.string "street"
    t.string "address"
    t.string "zip_code"
    t.string "state"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "avg_pricings", "restaurants"
  add_foreign_key "dish_categories", "dish_types"
  add_foreign_key "dish_categories", "dishes"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "open_hours", "restaurants"
  add_foreign_key "restaurant_addresses", "restaurants"
  add_foreign_key "restaurant_categories", "categories"
  add_foreign_key "restaurant_categories", "restaurants"
  add_foreign_key "restaurant_cuisines", "cuisines"
  add_foreign_key "restaurant_cuisines", "restaurants"
  add_foreign_key "restaurant_menus", "restaurants"
  add_foreign_key "restaurant_open_days", "open_days"
  add_foreign_key "restaurant_open_days", "restaurants"
  add_foreign_key "restaurant_users", "admin_users"
  add_foreign_key "restaurant_users", "restaurants"
end
