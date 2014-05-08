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

ActiveRecord::Schema.define(version: 20140508071555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "description"
    t.float    "amount"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shot_lists", force: true do |t|
    t.text     "shots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
    t.integer  "shooter_id"
    t.integer  "competition_id"
  end

  add_index "shot_lists", ["competition_id"], name: "index_shot_lists_on_competition_id", using: :btree
  add_index "shot_lists", ["contest_id"], name: "index_shot_lists_on_contest_id", using: :btree
  add_index "shot_lists", ["shooter_id"], name: "index_shot_lists_on_shooter_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
