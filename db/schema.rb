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

ActiveRecord::Schema.define(version: 20141023071135) do

  create_table "contacts", force: true do |t|
    t.integer  "contact_id"
    t.integer  "dialog_id"
    t.integer  "user_id"
    t.boolean  "active",     default: false
    t.integer  "counter",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "dialogs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messagephotos", force: true do |t|
    t.integer  "message_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messagephotos", ["message_id"], name: "index_messagephotos_on_message_id"
  add_index "messagephotos", ["photo_id"], name: "index_messagephotos_on_photo_id"

  create_table "messages", force: true do |t|
    t.integer  "dialog_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["dialog_id"], name: "index_messages_on_dialog_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.string   "secret",     limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "users", force: true do |t|
    t.string   "token",      limit: 32
    t.string   "name"
    t.string   "gender"
    t.string   "color"
    t.integer  "image",                 default: 0
    t.integer  "search",     limit: 1,  default: 1
    t.boolean  "online",                default: false
    t.string   "who",                   default: "all"
    t.integer  "how",        limit: 1,  default: 1
    t.integer  "sound",      limit: 2,  default: 1
    t.string   "avatar",     limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true

end
