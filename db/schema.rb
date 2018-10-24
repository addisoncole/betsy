# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_24_070458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.integer "quantity", default: 1
    t.bigint "product_id"
    t.string "status", default: "pending"
    t.index ["order_id"], name: "index_cart_entries_on_order_id"
    t.index ["product_id"], name: "index_cart_entries_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "card_number"
    t.string "card_expiration"
    t.integer "CVV"
    t.integer "billing_zip_code"
    t.string "shipping_address"
    t.string "email"
    t.string "billing_address"
    t.string "status", default: "pending"
    t.string "name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating"
    t.string "comment"
    t.bigint "product_id"
    t.bigint "user_id"
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.boolean "merchant", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uid", null: false
    t.string "provider", null: false
    t.string "store_name"
    t.string "store_banner_img"
    t.string "store_location"
    t.string "store_description"
    t.string "profile_picture"
  end

  add_foreign_key "cart_entries", "orders"
  add_foreign_key "cart_entries", "products"
  add_foreign_key "products", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
end
