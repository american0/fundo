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

ActiveRecord::Schema.define(version: 20171009185918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "foundations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "country_alpha2"
    t.string "local_currency"
    t.string "postal_code"
    t.integer "min_starting_funds"
    t.integer "min_participants"
    t.datetime "activation_deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "locality_name"
    t.string "address"
    t.datetime "activated_on"
    t.index ["created_at"], name: "index_foundations_on_created_at"
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "pledge_id"
    t.uuid "foundation_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_payments_on_created_at"
    t.index ["foundation_id"], name: "index_payments_on_foundation_id"
    t.index ["pledge_id"], name: "index_payments_on_pledge_id"
  end

  create_table "pledges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "foundation_id"
    t.string "address"
    t.decimal "amount", precision: 11, scale: 2
    t.string "currency"
    t.datetime "cancelled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_pledges_on_created_at"
    t.index ["foundation_id"], name: "index_pledges_on_foundation_id"
    t.index ["user_id"], name: "index_pledges_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "foundation_id"
    t.uuid "project_owner_id"
    t.text "short_description"
    t.text "full_description"
    t.decimal "funding_goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "title"
    t.index ["created_at"], name: "index_projects_on_created_at"
    t.index ["foundation_id"], name: "index_projects_on_foundation_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "foundation_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "sender_id"
    t.uuid "recipient_id"
    t.index ["created_at"], name: "index_transactions_on_created_at"
    t.index ["foundation_id"], name: "index_transactions_on_foundation_id"
    t.index ["recipient_id"], name: "index_transactions_on_recipient_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "walletable_type"
    t.uuid "walletable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "foundation_id"
    t.string "content_type"
  end

  add_foreign_key "payments", "foundations"
  add_foreign_key "payments", "pledges"
  add_foreign_key "pledges", "foundations"
  add_foreign_key "pledges", "users"
  add_foreign_key "projects", "foundations"
  add_foreign_key "transactions", "foundations"
end
