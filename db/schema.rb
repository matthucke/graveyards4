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

ActiveRecord::Schema.define(version: 20140413202014) do

  create_table "counties", force: true do |t|
    t.integer  "state_id"
    t.integer  "county_type", default: 0
    t.string   "name"
    t.string   "path"
    t.string   "full_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "boundary"
  end

  add_index "counties", ["state_id"], name: "index_counties_on_state_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "state_code",   limit: 20
    t.string   "country_code", limit: 2
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
