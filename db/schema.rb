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

ActiveRecord::Schema[7.0].define(version: 2023_06_19_081437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account1s", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "accountable_type"
    t.bigint "accountable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["accountable_type", "accountable_id"], name: "index_account1s_on_accountable"
    t.index ["email"], name: "index_account1s_on_email", unique: true
    t.index ["reset_password_token"], name: "index_account1s_on_reset_password_token", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "accountable_type"
    t.bigint "accountable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "applicants", force: :cascade do |t|
    t.string "status"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "renter_id"
    t.index ["product_id"], name: "index_applicants_on_product_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "location"
    t.bigint "payment_history_id", null: false
    t.bigint "rental_history_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_history_id"], name: "index_deliveries_on_payment_history_id"
    t.index ["rental_history_id"], name: "index_deliveries_on_rental_history_id"
  end

  create_table "payment_histories", force: :cascade do |t|
    t.bigint "rental_history_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cardnumber"
    t.string "cvc"
    t.integer "amount"
    t.date "expiry"
    t.index ["rental_history_id"], name: "index_payment_histories_on_rental_history_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rent"
    t.string "description"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.string "comment"
    t.string "ratable_type", null: false
    t.bigint "ratable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from_id"
    t.index ["ratable_type", "ratable_id"], name: "index_ratings_on_ratable"
  end

  create_table "rental_histories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "renter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_rental_histories_on_product_id"
    t.index ["renter_id"], name: "index_rental_histories_on_renter_id"
  end

  create_table "renters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "aadhar"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applicants", "products"
  add_foreign_key "deliveries", "payment_histories"
  add_foreign_key "deliveries", "rental_histories"
  add_foreign_key "payment_histories", "rental_histories"
  add_foreign_key "products", "users"
  add_foreign_key "rental_histories", "products"
  add_foreign_key "rental_histories", "renters"
end
