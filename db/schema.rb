# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_23_143637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index %w[blob_id], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id],
            name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index %w[key], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'bookings', force: :cascade do |t|
    t.float 'price'
    t.bigint 'user_id', null: false
    t.bigint 'station_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.date 'date'
    t.bigint 'kitchen_id', null: false
    t.string 'period'
    t.index %w[kitchen_id], name: 'index_bookings_on_kitchen_id'
    t.index %w[station_id], name: 'index_bookings_on_station_id'
    t.index %w[user_id], name: 'index_bookings_on_user_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'items', force: :cascade do |t|
    t.string 'dish'
    t.text 'description'
    t.string 'category'
    t.float 'price'
    t.string 'allergen'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id', null: false
    t.string 'ingredient'
    t.bigint 'kitchen_id', null: false
    t.index %w[kitchen_id], name: 'index_items_on_kitchen_id'
    t.index %w[user_id], name: 'index_items_on_user_id'
  end

  create_table 'kitchens', force: :cascade do |t|
    t.string 'name'
    t.string 'cuisine'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[user_id], name: 'index_kitchens_on_user_id'
  end

  create_table 'line_items', force: :cascade do |t|
    t.bigint 'item_id', null: false
    t.bigint 'cart_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'quantity', default: 1
    t.index %w[cart_id], name: 'index_line_items_on_cart_id'
    t.index %w[item_id], name: 'index_line_items_on_item_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'status', default: 'Pending'
    t.string 'delivery_address'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id', null: false
    t.bigint 'cart_id'
    t.bigint 'item_id'
    t.index %w[cart_id], name: 'index_orders_on_cart_id'
    t.index %w[item_id], name: 'index_orders_on_item_id'
    t.index %w[user_id], name: 'index_orders_on_user_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'rating'
    t.text 'content'
    t.bigint 'user_id', null: false
    t.bigint 'kitchen_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[kitchen_id], name: 'index_reviews_on_kitchen_id'
    t.index %w[user_id], name: 'index_reviews_on_user_id'
  end

  create_table 'stations', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'available', default: true
    t.string 'name'
    t.string 'description'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.text 'description'
    t.boolean 'chef', default: false
    t.boolean 'chef_status', default: false
    t.string 'first_name'
    t.string 'last_name'
    t.string 'address', default: '138 Kingsland Road'
    t.index %w[email], name: 'index_users_on_email', unique: true
    t.index %w[reset_password_token],
            name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments',
                  'active_storage_blobs',
                  column: 'blob_id'
  add_foreign_key 'bookings', 'kitchens'
  add_foreign_key 'bookings', 'stations'
  add_foreign_key 'bookings', 'users'
  add_foreign_key 'items', 'kitchens'
  add_foreign_key 'items', 'users'
  add_foreign_key 'kitchens', 'users'
  add_foreign_key 'line_items', 'carts'
  add_foreign_key 'line_items', 'items'
  add_foreign_key 'orders', 'carts'
  add_foreign_key 'orders', 'items'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'reviews', 'kitchens'
  add_foreign_key 'reviews', 'users'
end
