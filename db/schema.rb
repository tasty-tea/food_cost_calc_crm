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

ActiveRecord::Schema.define(version: 2019_09_23_111013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fixed_costs", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "cost", default: "0.0", null: false
    t.integer "frequency", default: 0, null: false
    t.datetime "date_started"
    t.datetime "date_finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "stock_unit_id"
    t.bigint "product_id"
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ingredients_on_product_id"
    t.index ["stock_unit_id"], name: "index_ingredients_on_stock_unit_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "cost", default: "0.0", null: false
    t.integer "servings", default: 1, null: false
    t.integer "estimated_sold", default: 0, null: false
    t.boolean "is_unit_economics", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellings", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.integer "amount", default: 0, null: false
    t.boolean "brake", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sellings_on_product_id"
    t.index ["user_id"], name: "index_sellings_on_user_id"
  end

  create_table "stock_movements", force: :cascade do |t|
    t.bigint "stock_unit_id", null: false
    t.integer "amount", default: 0, null: false
    t.decimal "cost", default: "0.0", null: false
    t.string "measure_units", default: ""
    t.boolean "brake", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_unit_id"], name: "index_stock_movements_on_stock_unit_id"
  end

  create_table "stock_units", force: :cascade do |t|
    t.string "name", null: false
    t.integer "amount", default: 0, null: false
    t.integer "rejected", default: 0, null: false
    t.decimal "cost", default: "0.0", null: false
    t.string "measure_units", default: "pieces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ingredients", "products"
  add_foreign_key "ingredients", "stock_units"
  add_foreign_key "sellings", "products"
  add_foreign_key "sellings", "users"
  add_foreign_key "stock_movements", "stock_units"
end
