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

ActiveRecord::Schema.define(version: 20170106175132) do

  create_table "features", force: :cascade do |t|
    t.integer  "sprint_id"
    t.integer  "rank"
    t.decimal  "estimated_total_hours"
    t.decimal  "estimated_remaining_hours"
    t.decimal  "actual_worked_hours"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["sprint_id"], name: "index_features_on_sprint_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
