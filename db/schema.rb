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

ActiveRecord::Schema.define(version: 20140710174752) do

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

  create_table "featured_sites", force: true do |t|
    t.string   "section"
    t.integer  "sort_order"
    t.integer  "graveyard_id"
    t.string   "url"
    t.string   "headline"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "featured_sites", ["graveyard_id"], name: "index_featured_sites_on_graveyard_id", using: :btree

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
    t.string   "avatar"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "og1", id: false, force: true do |t|
    t.integer "id",                                                    default: 0,    null: false
    t.string  "name",              limit: 80,                                         null: false
    t.string  "latitude_dms",      limit: 8
    t.string  "longitude_dms",     limit: 8
    t.string  "usgsmap",           limit: 30
    t.string  "county_name",       limit: 20
    t.string  "state",             limit: 2,                           default: "IL", null: false
    t.integer "rating",                                                default: 0
    t.string  "denomination",      limit: 2
    t.integer "yearstarted",                                           default: 0
    t.integer "visited",                                               default: 0
    t.string  "visitdate",         limit: 12
    t.string  "note",              limit: 120
    t.integer "status",                                                default: 0
    t.string  "address",           limit: 60,                          default: ""
    t.string  "city",              limit: 30
    t.string  "phone",             limit: 12
    t.string  "zip",               limit: 5
    t.string  "contributor_name",  limit: 40
    t.string  "imagename",         limit: 40,                          default: ""
    t.string  "feature_url",       limit: 100
    t.integer "usgsid",            limit: 8,                           default: 0
    t.integer "parentid",                                              default: 0
    t.decimal "latitude",                      precision: 8, scale: 6
    t.decimal "longitude",                     precision: 8, scale: 6
    t.string  "flags",             limit: 10,                          default: ""
    t.string  "source",            limit: 12,                          default: ""
    t.string  "contributor2_name", limit: 40
    t.string  "homepage",          limit: 80,                          default: ""
    t.string  "feature_type",      limit: 1,                           default: "G"
    t.integer "county_id",                                             default: 0
    t.string  "shortname",         limit: 60,                          default: ""
    t.integer "contributor_id",                                        default: 0
    t.integer "contributor2_id",                                       default: 0
    t.string  "book_code",         limit: 10,                          default: ""
    t.string  "book_section",      limit: 5,                           default: ""
    t.string  "url"
    t.integer "main_photo_id"
    t.integer "photos_count",                                          default: 0
  end

  create_table "photo_migrations", force: true do |t|
    t.integer  "county_id"
    t.integer  "graveyard_id"
    t.integer  "contributor_id"
    t.string   "contributor_name"
    t.string   "old_path"
    t.string   "graveyard_name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "status",           limit: 10
  end

  create_table "photos", force: true do |t|
    t.integer  "status",                      default: 0
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "score",                       default: 0
    t.integer  "votes",                       default: 0
    t.integer  "graveyard_id"
    t.integer  "plot_id"
    t.integer  "person_id"
    t.integer  "story_id"
    t.integer  "width"
    t.integer  "height"
    t.string   "flags",           limit: 10,  default: ""
    t.string   "title",           limit: 100, default: ""
    t.string   "location",        limit: 100, default: ""
    t.text     "caption"
    t.string   "format",          limit: 3,   default: "jpg"
    t.string   "upload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "md5sum",          limit: 32
    t.text     "migration_notes"
    t.integer  "migration_id"
    t.text     "old_path"
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
    t.string   "full_name"
    t.integer  "security_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "username"
  end

  create_table "visit_migrations", id: false, force: true do |t|
    t.integer "id",                      default: 0, null: false
    t.integer "graveyard_id",            default: 0, null: false
    t.integer "visited",                 default: 0
    t.string  "visitdate",    limit: 12
  end

  create_table "visits", force: true do |t|
    t.integer  "user_id"
    t.integer  "graveyard_id"
    t.date     "visited_on"
    t.integer  "quality"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       limit: 10, default: "visited"
    t.integer  "visibility",              default: 1000
  end

  add_index "visits", ["graveyard_id"], name: "index_visits_on_graveyard_id", using: :btree
  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

end
