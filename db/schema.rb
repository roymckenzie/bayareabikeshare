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

ActiveRecord::Schema.define(version: 20140408185032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bart_stations", force: true do |t|
    t.string   "name"
    t.string   "id_abbr"
    t.string   "abbr"
    t.float    "lat"
    t.float    "lon"
    t.string   "address"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.string  "name"
    t.float   "lat"
    t.float   "lon"
    t.integer "dockcount"
    t.string  "landmark"
    t.date    "installation"
  end

  create_table "trips", force: true do |t|
    t.integer  "duration"
    t.datetime "start_date"
    t.integer  "start_station_id"
    t.datetime "end_date"
    t.integer  "end_station_id"
    t.integer  "bike_id"
    t.boolean  "subscription"
    t.string   "zip"
  end

  add_index "trips", ["end_station_id"], name: "index_trips_on_end_station_id", using: :btree
  add_index "trips", ["start_station_id"], name: "index_trips_on_start_station_id", using: :btree

end
