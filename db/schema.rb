# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_06_025010) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats", force: :cascade do |t|
    t.integer "season"
    t.integer "games"
    t.integer "atbat"
    t.integer "runs"
    t.integer "hits"
    t.integer "singles"
    t.integer "doubles"
    t.integer "triples"
    t.integer "homeruns"
    t.integer "rbi"
    t.integer "k"
    t.integer "tb"
    t.integer "sac"
    t.integer "gwrbi"
    t.float "avg"
    t.float "obp"
    t.float "slg"
    t.float "ops"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "years"
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.string "team"
    t.index ["player_id"], name: "index_stats_on_player_id"
    t.index ["season_id"], name: "index_stats_on_season_id"
  end

  add_foreign_key "stats", "players"
  add_foreign_key "stats", "seasons"
end
