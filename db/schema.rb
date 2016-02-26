# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160226081535) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "area_cities", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "province_code"
    t.integer "position",      default: 0
  end

  create_table "area_provinces", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.integer "position", default: 0
  end

  create_table "area_streets", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "city_code"
    t.integer "position",  default: 0
  end

  create_table "banners", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url",         limit: 500
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "total",      default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributions", force: true do |t|
    t.integer  "user_id"
    t.integer  "level"
    t.integer  "score",                   default: 0
    t.string   "state"
    t.string   "phone"
    t.string   "city"
    t.string   "readme",     limit: 2000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remark",     limit: 2000
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_products", force: true do |t|
    t.integer "user_id"
    t.integer "order_id"
    t.integer "product_id"
    t.string  "name"
    t.integer "total"
    t.decimal "amount",     precision: 10, scale: 2
    t.decimal "price",      precision: 10, scale: 2
    t.string  "logo"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "scode"
    t.decimal  "fare",             precision: 10, scale: 2
    t.decimal  "total_fee",        precision: 10, scale: 2
    t.string   "state"
    t.string   "remark"
    t.string   "receiver_name"
    t.string   "receiver_phone"
    t.string   "receiver_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "express"
    t.string   "express_number"
  end

  create_table "product_categories", force: true do |t|
    t.string  "name"
    t.string  "logo"
    t.integer "parent_id"
    t.integer "lft",                        null: false
    t.integer "rgt",                        null: false
    t.integer "depth",          default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.integer "position",       default: 0
  end

  create_table "product_logos", force: true do |t|
    t.integer "product_id"
    t.string  "logo"
    t.integer "position",   default: 0
  end

  create_table "products", force: true do |t|
    t.integer "product_category_id"
    t.string  "name"
    t.string  "description"
    t.integer "inventory"
    t.decimal "old_price",            precision: 10, scale: 2
    t.decimal "price",                precision: 10, scale: 2
    t.text    "content"
    t.string  "state"
    t.integer "position",                                      default: 0
    t.boolean "recommend",                                     default: false
    t.boolean "sticky",                                        default: false
    t.integer "order_products_count",                          default: 0
  end

  create_table "shippin_addresses", force: true do |t|
    t.integer "user_id"
    t.string  "province_code"
    t.string  "city_code"
    t.string  "street_code"
    t.string  "detail",        limit: 500
    t.string  "name"
    t.string  "phone"
    t.boolean "default",                   default: false
  end

  create_table "users", force: true do |t|
    t.string "name"
  end

end
