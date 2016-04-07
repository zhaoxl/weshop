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

ActiveRecord::Schema.define(version: 20160407081746) do

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
    t.integer  "role_id"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_roles", id: false, force: true do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "agents", force: true do |t|
    t.string   "province_code"
    t.string   "city_code"
    t.string   "name"
    t.integer  "position",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "total",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupon_template_product_categories", force: true do |t|
    t.integer "product_category_id"
    t.integer "coupon_template_id"
  end

  create_table "coupon_templates", force: true do |t|
    t.string  "name"
    t.decimal "price", precision: 10, scale: 2, default: 0.0
  end

  create_table "coupons", force: true do |t|
    t.integer  "user_id"
    t.integer  "coupon_template_id"
    t.string   "name"
    t.decimal  "price",              precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "desc"
  end

  create_table "distribution_incomes", force: true do |t|
    t.integer  "distribution_id"
    t.integer  "product_id"
    t.integer  "order_product_id"
    t.integer  "order_id"
    t.integer  "buy_user_id"
    t.decimal  "total",            precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distribution_settings", force: true do |t|
    t.integer "v1"
    t.integer "v2"
    t.integer "v3"
  end

  create_table "distributions", force: true do |t|
    t.integer  "user_id"
    t.integer  "level"
    t.decimal  "score",                   precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.string   "phone"
    t.string   "city"
    t.string   "readme",     limit: 2000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remark",     limit: 2000
  end

  create_table "dividend_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "recommend_user_id"
    t.decimal  "amount",            precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expresses", force: true do |t|
    t.string  "name"
    t.string  "code"
    t.integer "position"
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
    t.decimal "amount",      precision: 10, scale: 2
    t.decimal "price",       precision: 10, scale: 2
    t.string  "logo"
    t.string  "description"
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
    t.integer  "coupon_id"
    t.decimal  "coupon_fee",       precision: 10, scale: 2, default: 0.0
    t.datetime "payment_at"
    t.datetime "sent_at"
    t.datetime "receive_at"
  end

  create_table "pay_logs", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "pay_type"
    t.string   "trade_type"
    t.string   "log",        limit: 5000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "desc",       limit: 500
    t.string   "scode"
    t.decimal  "amount",                 precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "goto",       limit: 500
  end

  create_table "permissions", force: true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.integer  "depth",          default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hide",           default: false
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
    t.integer  "product_category_id"
    t.string   "name"
    t.string   "description"
    t.integer  "inventory"
    t.decimal  "old_price",            precision: 10, scale: 2
    t.decimal  "price",                precision: 10, scale: 2
    t.text     "content"
    t.string   "state"
    t.integer  "position",                                      default: 0
    t.boolean  "recommend",                                     default: false
    t.boolean  "sticky",                                        default: false
    t.integer  "order_products_count",                          default: 0
    t.integer  "coupon_template_id"
    t.string   "front_logo"
    t.integer  "handsel_score"
    t.integer  "agent_id"
    t.datetime "deleted_at"
  end

  create_table "recharge_card_categories", force: true do |t|
    t.string  "name"
    t.decimal "price", precision: 10, scale: 2
  end

  create_table "recharge_cards", force: true do |t|
    t.integer  "recharge_card_id"
    t.integer  "user_id"
    t.string   "scode"
    t.string   "name"
    t.string   "state"
    t.decimal  "price",            precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "handsel",          precision: 10, scale: 2, default: 0.0
  end

  create_table "recharges", force: true do |t|
    t.integer  "user_id"
    t.string   "scode"
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string  "name"
    t.string  "state"
    t.string  "resource_type"
    t.integer "resource_id"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles_permissions", force: true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "settings", force: true do |t|
    t.string "key"
    t.string "desc"
    t.text   "value"
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

  create_table "single_articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "can_delete", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "recommend_user_id"
    t.datetime "created_at"
    t.string   "open_id"
    t.string   "token",             limit: 500
    t.string   "headimgurl",        limit: 1000
    t.string   "qrcode"
  end

  create_table "wallets", force: true do |t|
    t.integer "user_id"
    t.decimal "balance", precision: 10, scale: 2, default: 0.0
    t.decimal "lock",    precision: 10, scale: 2, default: 0.0
    t.integer "score",                            default: 0
  end

  create_table "wechat_sessions", force: true do |t|
    t.string   "openid",     null: false
    t.string   "hash_store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wechat_sessions", ["openid"], name: "index_wechat_sessions_on_openid", unique: true, using: :btree

  create_table "withdraws", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
