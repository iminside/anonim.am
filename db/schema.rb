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

ActiveRecord::Schema.define(version: 20140718051317) do

  create_table "contacts", force: true do |t|
    t.integer  "contact_id"
    t.integer  "dialog_id"
    t.integer  "user_id"
    t.boolean  "active",     default: false
    t.integer  "counter",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["contact_id", "user_id"], name: "index_contacts_on_contact_id_and_user_id", unique: true

  create_table "dialogs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "dialog_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "token"
    t.string   "name"
    t.string   "gender"
    t.string   "color"
    t.integer  "image",                default: 0
    t.integer  "search",     limit: 1, default: 1
    t.boolean  "online",               default: false
    t.string   "who",                  default: "all"
    t.integer  "how",        limit: 1, default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
