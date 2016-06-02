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

ActiveRecord::Schema.define(version: 20160602174314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "establishments", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "lat"
    t.string   "lng"
    t.string   "id_places"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.float    "woman"
    t.float    "lgbtqia"
    t.float    "black"
    t.float    "disability"
    t.float    "elder"
    t.float    "obese"
    t.string   "name"
    t.string   "cpf"
    t.string   "email"
    t.string   "phone"
    t.date     "rating_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "establishment_id"
  end

end
