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

ActiveRecord::Schema.define(version: 20170110000047) do

  create_table "features", force: :cascade do |t|
    t.integer  "sprint_id"
    t.string   "title"
    t.integer  "rank",                      null: false
    t.decimal  "estimated_total_hours",     null: false
    t.decimal  "estimated_remaining_hours", null: false
    t.decimal  "actual_worked_hours",       null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["sprint_id"], name: "index_features_on_sprint_id"
  end

  create_table "sprint_users", force: :cascade do |t|
    t.integer  "sprint_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id"], name: "index_sprint_users_on_sprint_id"
    t.index ["user_id"], name: "index_sprint_users_on_user_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string   "title",      null: false
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "auth_provider", null: false
    t.string   "uid",           null: false
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["auth_provider", "uid"], name: "index_users_on_auth_provider_and_uid", unique: true
  end

end
