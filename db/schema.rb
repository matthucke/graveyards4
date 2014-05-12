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

ActiveRecord::Schema.define(version: 20140512001914) do

  create_table "book_chapters", force: true do |t|
    t.string   "qr_code",      limit: 30
    t.integer  "sort_order",              default: 99999
    t.integer  "graveyard_id"
    t.string   "title"
    t.text     "main_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counties", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "path"
    t.string   "full_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "boundary"
    t.string   "type_name",     default: "County"
    t.integer  "main_photo_id"
  end

  add_index "counties", ["main_photo_id"], name: "index_counties_on_main_photo_id", using: :btree
  add_index "counties", ["state_id"], name: "index_counties_on_state_id", using: :btree

  create_table "graveyards", force: true do |t|
    t.integer  "feature_type",                           default: 0
    t.integer  "county_id"
    t.integer  "status"
    t.string   "name"
    t.string   "path"
    t.decimal  "lat",           precision: 10, scale: 6
    t.decimal  "lng",           precision: 10, scale: 6
    t.integer  "year_started"
    t.integer  "usgs_id"
    t.string   "usgs_map"
    t.string   "homepage"
    t.string   "full_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main_photo_id"
  end

  add_index "graveyards", ["county_id"], name: "index_graveyards_on_county_id", using: :btree
  add_index "graveyards", ["main_photo_id"], name: "index_graveyards_on_main_photo_id", using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.text     "provider_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "status",                   default: 0
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "score",                    default: 0
    t.integer  "votes",                    default: 0
    t.integer  "graveyard_id"
    t.integer  "plot_id"
    t.integer  "width"
    t.integer  "height"
    t.string   "flags",        limit: 10,  default: ""
    t.string   "title",        limit: 100, default: ""
    t.string   "location",     limit: 100, default: ""
    t.text     "caption"
    t.string   "format",       limit: 3,   default: "jpg"
    t.string   "upload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "state_code",   limit: 20
    t.string   "country_code", limit: 2
    t.string   "name"
    t.string   "path"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "security_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "username"
  end

end
