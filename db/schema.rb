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

ActiveRecord::Schema.define(version: 20140521062230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "building"
    t.integer  "flat"
    t.integer  "shooter_id"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.string   "classification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_shots"
    t.integer  "contest_id"
  end

  create_table "competitors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "club"
    t.boolean  "pk"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
  end

  add_index "competitors", ["contest_id"], name: "index_competitors_on_contest_id", using: :btree

  create_table "configurations", force: true do |t|
    t.string   "club_logo"
    t.string   "club_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "judgements", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
    t.integer  "judge_id"
  end

  create_table "judges", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "function"
    t.string   "license_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "description"
    t.float    "amount"
    t.date     "date"
    t.integer  "shooter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "expiry_date"
  end

  create_table "shooters", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "pesel"
    t.string   "phone"
    t.string   "email"
    t.date     "joined_date"
    t.string   "resolution_number"
    t.string   "license_number"
    t.boolean  "sport_permission"
    t.boolean  "handgun"
    t.boolean  "rifle"
    t.boolean  "shotgun"
    t.boolean  "collectors_permission"
    t.integer  "address_id"
    t.integer  "second_address_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_of_birth"
    t.string   "judge_license_number"
    t.boolean  "active",                default: true
  end

  create_table "shootings", force: true do |t|
    t.integer  "competitor_id"
    t.integer  "competition_id"
    t.text     "target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shootings", ["competition_id"], name: "index_shootings_on_competition_id", using: :btree
  add_index "shootings", ["competitor_id"], name: "index_shootings_on_competitor_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
