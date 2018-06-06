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

ActiveRecord::Schema.define(version: 2018_06_06_091846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acquire_rewards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "addressable_id"
    t.integer "state_id"
    t.string "addressable_type"
    t.string "street"
    t.string "complement"
    t.string "number"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.boolean "main_address", default: false
    t.string "neighborhood"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "subject"
    t.string "origin"
    t.text "message"
    t.integer "created_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_job", default: true
    t.index ["organization_id"], name: "index_employments_on_organization_id"
    t.index ["user_id"], name: "index_employments_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "trading_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_user_id"
    t.integer "owner_id"
    t.integer "stars_by_month"
    t.text "organization_tags", default: [], array: true
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.string "phoneable_type"
    t.integer "phoneable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "donator_id"
    t.integer "beneficiary_id"
    t.string "cause"
    t.string "star_amount"
    t.integer "amount"
    t.integer "organization_id"
    t.text "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.string "displaed_cost"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.integer "created_by_user_id"
    t.integer "quantity_available"
    t.integer "quantity_total"
    t.text "description"
  end

  create_table "star_bags", force: :cascade do |t|
    t.integer "user_id"
    t.integer "organization_id"
    t.integer "star_amount", default: 0
    t.integer "available_stars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "image"
    t.string "email"
    t.string "secondary_email"
    t.integer "created_by_user_id"
    t.boolean "active", default: false
    t.integer "role", default: 0
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "employments", "organizations"
  add_foreign_key "employments", "users"
end
